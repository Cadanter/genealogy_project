"""
Henry numbering system for the Van Eeden Family Archive.

Oldest ancestor:            a1
His children (by birth):    a1b1, a1b2, a1b3 ...
Their children:             a1b1c1, a1b1c2 ... a1b2c1 ...

Only 'parent' relationships count.
Children are ordered by birth year; unknown dates sort last.
Depth beyond 26 letters wraps: aa, ab, ac ...
"""

LETTERS = 'abcdefghijklmnopqrstuvwxyz'


def _depth_letter(depth):
    """
    Convert a 0-based depth to a letter sequence.
    depth 0 → 'a', depth 25 → 'z', depth 26 → 'aa', depth 27 → 'ab' ...
    """
    result = ''
    n = depth + 1
    while n > 0:
        n, remainder = divmod(n - 1, 26)
        result = LETTERS[remainder] + result
    return result


def _birth_sort_key(person):
    """Sort key for ordering siblings by birth year."""
    from .gedcom_dates import parse_gedcom_date
    parsed = parse_gedcom_date(person.birth_date)
    try:
        return int(parsed.get('year', 9999)) if parsed else 9999
    except (ValueError, TypeError):
        return 9999


def _get_children(person):
    """Return biological children of a person ordered by birth year."""
    from .models import Person
    children = Person.objects.filter(
        child_relationships__person=person,
        child_relationships__relationship_type='parent'
    ).distinct()
    return sorted(children, key=_birth_sort_key)


def compute_henry_for_tree(root):
    """
    Compute Henry numbers for all people reachable from root.
    Returns a dict: {person_pk: henry_number}
    Uses iterative depth-first walk to avoid recursion limits on deep trees.
    """
    cache = {root.pk: 'a1'}
    # Stack entries: (person, current_number, depth)
    stack = [(root, 'a1', 1)]
    while stack:
        person, number, depth = stack.pop()
        letter = _depth_letter(depth)
        children = _get_children(person)
        for i, child in enumerate(children, start=1):
            child_number = f'{number}{letter}{i}'
            cache[child.pk] = child_number
            stack.append((child, child_number, depth + 1))
    return cache


def get_henry_number(person, root=None):
    """
    Get the Henry number for a single person.
    Optionally pass the root Person to avoid a DB query.
    Returns a string like 'a1b3c2' or '' if not connected to root.
    """
    from .models import Person
    if root is None:
        root = Person.objects.filter(is_root=True).first()
    if root is None:
        return ''
    cache = compute_henry_for_tree(root)
    return cache.get(person.pk, '')
