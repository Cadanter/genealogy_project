"""
gedcom_dates.py
Utilities for storing and displaying GEDCOM date strings.
The Person/Marriage/Event models store dates as CharField (GEDCOM strings).
This module handles parsing, display, and age calculation.
"""
import re

MONTHS_GED = ['JAN','FEB','MAR','APR','MAY','JUN',
               'JUL','AUG','SEP','OCT','NOV','DEC']

MODIFIER_AF = {
    'BEF': 'Voor',
    'AFT': 'Na',
    'EST': 'Ongeveer',
    'BET': 'Tussen',
    'ABT': 'Ongeveer',
    'CAL': 'Bereken',
}


def parse_gedcom_date(gedcom_str):
    """
    Parse a GEDCOM date string into a dict:
    { modifier, day, month, year, day2, month2, year2 }
    All numeric values as ints, None if missing.
    """
    if not gedcom_str:
        return None
    s = gedcom_str.strip().upper()
    if not s or s in ('ONBEKEND', 'UNKNOWN'):
        return {'modifier': 'UNK'}

    result = {'modifier': 'EXACT', 'day': None, 'month': None, 'year': None,
              'day2': None, 'month2': None, 'year2': None}

    # BET ... AND ...
    bet = re.match(r'^BET\s+(.+?)\s+AND\s+(.+)$', s)
    if bet:
        result['modifier'] = 'BET'
        _fill_date_parts(result, bet.group(1), '', '')
        _fill_date_parts(result, bet.group(2), '2', '2')
        return result

    # Single modifier
    mod_match = re.match(r'^(BEF|AFT|EST|ABT|CAL|INT)\s+(.+)$', s)
    if mod_match:
        result['modifier'] = mod_match.group(1)
        _fill_date_parts(result, mod_match.group(2), '', '')
        return result

    # Plain date
    _fill_date_parts(result, s, '', '')
    return result


def _fill_date_parts(result, date_str, day_key, month_key):
    """Fill day/month/year into result dict from a date string fragment."""
    dk = 'day' + day_key
    mk = 'month' + month_key
    yk = 'year' + day_key  # year uses same suffix as day

    parts = date_str.strip().split()
    for part in parts:
        if part in MONTHS_GED:
            result[mk] = MONTHS_GED.index(part) + 1
        elif re.match(r'^\d{1,4}$', part):
            num = int(part)
            if num <= 31 and result.get(mk) is None and result.get(dk) is None:
                # Could be day — but if it's > 31 or only part, treat as year
                if num <= 31 and len(part) <= 2:
                    result[dk] = num
                else:
                    result[yk] = num
            elif num > 31 or len(part) == 4:
                result[yk] = num
            else:
                result[dk] = num


def gedcom_to_display(gedcom_str):
    """Convert a GEDCOM date string to an Afrikaans display string."""
    if not gedcom_str:
        return ''
    s = gedcom_str.strip().upper()
    if s in ('ONBEKEND', 'UNKNOWN', ''):
        return 'Onbekend'

    def fmt_part(date_str):
        parts = date_str.strip().split()
        day = month = year = None
        for part in parts:
            if part in MONTHS_GED:
                month = MONTHS_GED.index(part) + 1
            elif re.match(r'^\d{1,2}$', part) and int(part) <= 31:
                day = int(part)
            elif re.match(r'^\d{4}$', part):
                year = int(part)
        dd   = str(day).zfill(2)   if day   else '__'
        mm   = str(month).zfill(2) if month else '__'
        yyyy = str(year).zfill(4)  if year  else '____'
        return f'{dd}/{mm}/{yyyy}'

    bet = re.match(r'^BET\s+(.+?)\s+AND\s+(.+)$', s)
    if bet:
        return f"Tussen {fmt_part(bet.group(1))} en {fmt_part(bet.group(2))}"

    mod_match = re.match(r'^(BEF|AFT|EST|ABT|CAL)\s+(.+)$', s)
    if mod_match:
        mod_af = MODIFIER_AF.get(mod_match.group(1), mod_match.group(1))
        return f"{mod_af} {fmt_part(mod_match.group(2))}"

    return fmt_part(s)


def calc_age(birth_gedcom, death_gedcom):
    """
    Return an Afrikaans age string from two GEDCOM date strings.
    Returns 'Onbekend' whenever exact calculation is impossible.
    """
    if not birth_gedcom or not death_gedcom:
        return 'Onbekend'

    bp = parse_gedcom_date(birth_gedcom)
    dp = parse_gedcom_date(death_gedcom)

    if not bp or not dp:
        return 'Onbekend'
    if bp.get('modifier') == 'UNK' or dp.get('modifier') == 'UNK':
        return 'Onbekend'
    if not bp.get('year') or not dp.get('year'):
        return 'Onbekend'

    by, dy = bp['year'], dp['year']
    approx = bp.get('modifier') != 'EXACT' or dp.get('modifier') != 'EXACT'
    prefix = '± ' if approx else ''

    if not bp.get('month') or not dp.get('month') or \
       not bp.get('day') or not dp.get('day'):
        return f'{prefix}± {dy - by} jaar (benaderd)'

    from datetime import date
    try:
        bd = date(by, bp['month'], bp['day'])
        dd = date(dy, dp['month'], dp['day'])
    except ValueError:
        return 'Onbekend'

    age = dy - by
    if (dd.month, dd.day) < (bd.month, bd.day):
        age -= 1
    if age < 0:
        return 'Onbekend'
    return f'{prefix}{age} jaar'
