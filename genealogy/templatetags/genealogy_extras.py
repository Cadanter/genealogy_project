from django import template

register = template.Library()


@register.filter
def get_item(dictionary, key):
    """Allow dict[variable_key] lookups in templates: {{ my_dict|get_item:key }}"""
    if not dictionary:
        return ''
    return dictionary.get(key, '')
