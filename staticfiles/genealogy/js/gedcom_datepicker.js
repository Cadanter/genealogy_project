/*
 * gedcom_datepicker.js
 * Attach to any <input class="gedcom-date"> element.
 * Stores GEDCOM string in a paired hidden input (same name + "_gedcom").
 * Displays human-readable Afrikaans string in the visible input.
 */

(function () {
  'use strict';

  const MODS = [
    { key: 'EXACT', af: 'Presies', gedcom: '', single: true },
    { key: 'BEF', af: 'Voor', gedcom: 'BEF', single: true },
    { key: 'AFT', af: 'Na', gedcom: 'AFT', single: true },
    { key: 'EST', af: 'Ongeveer', gedcom: 'EST', single: true },
    { key: 'BET', af: 'Tussen', gedcom: 'BET', single: false },
    { key: 'UNK', af: 'Onbekend', gedcom: '', single: true },
  ];

  const MONTHS_GED = ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
    'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'];

  const MODIFIER_AF = {
    EXACT: '', BEF: 'Voor ', AFT: 'Na ', EST: 'Ongeveer ', BET: 'Tussen '
  };

  /* ── helpers ─────────────────────────────────────────────────────── */
  function padPart(val, len, forAft) {
    if (!val) return forAft ? '9'.repeat(len) : '0'.repeat(len);
    return String(val).padStart(len, '0');
  }

  function displayPart(val, len) {
    if (!val) return '_'.repeat(len);
    return String(val).padStart(len, '0');
  }

  function gedDate(d, m, y, isAft) {
    const day = padPart(d, 2, isAft);
    const mon = padPart(m, 2, isAft);
    const yr = padPart(y, 4, isAft);
    const mi = parseInt(mon, 10);
    const monStr = (mi >= 1 && mi <= 12) ? MONTHS_GED[mi - 1] : '';
    const dayStr = (day === '00' || day === '99') ? '' : String(parseInt(day, 10));
    const parts = [dayStr, monStr, yr === '0000' ? '' : yr].filter(Boolean);
    return parts.join(' ');
  }

  function buildGedcomStr(s) {
    if (s.mod === 'UNK') return '';
    const isAft = s.mod === 'AFT';
    const mod = MODS.find(x => x.key === s.mod);
    const prefix = mod.gedcom ? mod.gedcom + ' ' : '';
    if (s.mod === 'BET') {
      return 'BET ' + gedDate(s.d, s.m, s.y, false) +
        ' AND ' + gedDate(s.d2, s.m2, s.y2, false);
    }
    return prefix + gedDate(s.d, s.m, s.y, isAft);
  }

  function buildDisplayStr(s) {
    if (s.mod === 'UNK') return 'Onbekend';
    const mod = MODIFIER_AF[s.mod] || '';
    function dispDate(d, m, y) {
      return displayPart(d, 2) + '/' + displayPart(m, 2) + '/' + displayPart(y, 4);
    }
    if (s.mod === 'BET') {
      return mod + dispDate(s.d, s.m, s.y) + ' en ' + dispDate(s.d2, s.m2, s.y2);
    }
    return mod + dispDate(s.d, s.m, s.y);
  }

  /* ── age calculation ─────────────────────────────────────────────── */
  function calcAge(birthState, deathState) {
    if (!birthState || !deathState) return 'Onbekend';
    if (birthState.mod === 'UNK' || deathState.mod === 'UNK') return 'Onbekend';
    if (!birthState.y || !deathState.y) return 'Onbekend';
    const by = parseInt(birthState.y, 10);
    const dy = parseInt(deathState.y, 10);
    if (isNaN(by) || isNaN(dy)) return 'Onbekend';

    const approxOnly = !birthState.m || !deathState.m ||
      !birthState.d || !deathState.d;
    if (approxOnly) {
      return '± ' + (dy - by) + ' jaar (benaderd)';
    }
    const bd = new Date(by, parseInt(birthState.m, 10) - 1, parseInt(birthState.d, 10));
    const dd = new Date(dy, parseInt(deathState.m, 10) - 1, parseInt(deathState.d, 10));
    if (isNaN(bd.getTime()) || isNaN(dd.getTime())) return 'Onbekend';
    let age = dy - by;
    if (dd.getMonth() < bd.getMonth() ||
      (dd.getMonth() === bd.getMonth() && dd.getDate() < bd.getDate())) age--;
    if (age < 0) return 'Onbekend';
    const qualifier = (birthState.mod !== 'EXACT' || deathState.mod !== 'EXACT') ? '± ' : '';
    return qualifier + age + ' jaar';
  }

  /* ── popup HTML builder ──────────────────────────────────────────── */
  function buildPartInput(s, field, placeholder, maxLen, onUpdate) {
    const wrap = document.createElement('div');
    wrap.className = 'gdp-part';

    const lbl = document.createElement('div');
    lbl.className = 'gdp-part-label';
    lbl.textContent = placeholder === '__' ? 'Dag' : (maxLen === 2 ? 'Maand' : 'Jaar');
    wrap.appendChild(lbl);

    const inp = document.createElement('input');
    inp.type = 'text';
    inp.placeholder = '_'.repeat(maxLen);
    inp.maxLength = maxLen;
    inp.value = s[field] || '';
    inp.className = s[field] ? '' : 'gdp-unknown';
    inp.addEventListener('input', function () {
      let v = this.value.replace(/\D/g, '').slice(0, maxLen);
      this.value = v;
      s[field] = v;
      this.className = v ? '' : 'gdp-unknown';
      onUpdate();
    });
    wrap.appendChild(inp);
    return wrap;
  }

  function buildDateFields(s, df, mf, yf, onUpdate) {
    const row = document.createElement('div');
    row.className = 'gdp-date-row';
    row.appendChild(buildPartInput(s, df, '__', 2, onUpdate));
    row.appendChild(buildPartInput(s, mf, '__', 2, onUpdate));
    row.appendChild(buildPartInput(s, yf, '____', 4, onUpdate));
    return row;
  }

  function renderPopup(popup, s, onConfirm, onCancel) {
    popup.innerHTML = '';

    /* modifiers */
    const modLabel = document.createElement('div');
    modLabel.className = 'gdp-section-label';
    modLabel.textContent = 'Tipe datum';
    popup.appendChild(modLabel);

    const modGrid = document.createElement('div');
    modGrid.className = 'gdp-mod-grid';
    MODS.forEach(function (mod) {
      const btn = document.createElement('button');
      btn.type = 'button';
      btn.className = 'gdp-mod-btn' + (s.mod === mod.key ? ' active' : '');
      btn.textContent = mod.af;
      btn.addEventListener('click', function () {
        s.mod = mod.key;
        renderPopup(popup, s, onConfirm, onCancel);
      });
      modGrid.appendChild(btn);
    });
    popup.appendChild(modGrid);

    /* date fields */
    if (s.mod !== 'UNK') {
      const updatePreview = function () {
        previewEl.textContent = buildDisplayStr(s);
      };

      const dateLabel = document.createElement('div');
      dateLabel.className = 'gdp-section-label';
      dateLabel.textContent = s.mod === 'BET' ? 'Eerste datum' : 'Datum';
      popup.appendChild(dateLabel);
      popup.appendChild(buildDateFields(s, 'd', 'm', 'y', function () {
        previewEl.textContent = buildDisplayStr(s);
      }));

      if (s.mod === 'BET') {
        const div = document.createElement('div');
        div.className = 'gdp-bet-divider';
        div.textContent = 'tot / and';
        popup.appendChild(div);
        const d2Label = document.createElement('div');
        d2Label.className = 'gdp-section-label';
        d2Label.textContent = 'Tweede datum';
        popup.appendChild(d2Label);
        popup.appendChild(buildDateFields(s, 'd2', 'm2', 'y2', function () {
          previewEl.textContent = buildDisplayStr(s);
        }));
      }
    }

    /* preview */
    const prevLabel = document.createElement('div');
    prevLabel.className = 'gdp-section-label';
    prevLabel.textContent = 'Voorskou';
    popup.appendChild(prevLabel);

    const previewEl = document.createElement('div');
    previewEl.className = 'gdp-preview';
    previewEl.textContent = buildDisplayStr(s);
    popup.appendChild(previewEl);

    /* actions */
    const actions = document.createElement('div');
    actions.className = 'gdp-actions';

    const cancelBtn = document.createElement('button');
    cancelBtn.type = 'button';
    cancelBtn.className = 'gdp-btn';
    cancelBtn.textContent = 'Kanselleer';
    cancelBtn.addEventListener('click', onCancel);

    const confirmBtn = document.createElement('button');
    confirmBtn.type = 'button';
    confirmBtn.className = 'gdp-btn gdp-btn-primary';
    confirmBtn.textContent = 'Bevestig';
    confirmBtn.addEventListener('click', function () { onConfirm(s); });

    actions.appendChild(cancelBtn);
    actions.appendChild(confirmBtn);
    popup.appendChild(actions);
  }

  /* ── main attach function ────────────────────────────────────────── */
  function attachPicker(visibleInput) {
    const name = visibleInput.name || visibleInput.id;
    const form = visibleInput.closest('form');

    /* hidden input for GEDCOM value — strip _display suffix to find the real field */
    const realName = name.replace(/_display$/, '');
    let hiddenInput = form ? form.querySelector('input[name="' + realName + '"]') : null;
    if (!hiddenInput) {
      hiddenInput = document.createElement('input');
      hiddenInput.type = 'hidden';
      hiddenInput.name = realName;
      visibleInput.parentNode.insertBefore(hiddenInput, visibleInput.nextSibling);
    }

    /* state */
    const s = { mod: 'EXACT', d: '', m: '', y: '', d2: '', m2: '', y2: '' };

    /* popup container */
    const popup = document.createElement('div');
    popup.className = 'gdp-popup gdp-hidden';
    visibleInput.parentNode.style.position = 'relative';
    visibleInput.parentNode.appendChild(popup);

    let justOpened = false;

    function openPicker() {
      document.querySelectorAll('.gdp-popup').forEach(function (p) {
        if (p !== popup) p.classList.add('gdp-hidden');
      });
      renderPopup(popup, s,
        function (confirmed) {          /* onConfirm */
          visibleInput.value = buildDisplayStr(confirmed);
          hiddenInput.value = buildGedcomStr(confirmed);
          popup.classList.add('gdp-hidden');
          visibleInput.dispatchEvent(new Event('change', { bubbles: true }));
        },
        function () {                   /* onCancel */
          popup.classList.add('gdp-hidden');
        }
      );
      justOpened = true;
      popup.classList.remove('gdp-hidden');
    }

    visibleInput.readOnly = true;
    visibleInput.style.cursor = 'pointer';
    visibleInput.addEventListener('click', openPicker);
    visibleInput.addEventListener('keydown', function (e) {
      if (e.key === 'Enter' || e.key === ' ') { e.preventDefault(); openPicker(); }
      ignoreNextDocClick = true;
    });

    /* close on outside click */
    document.addEventListener('click', function (e) {
      if (ignoreNextDocClick) { ignoreNextDocClick = false; return; }
      if (!visibleInput.parentNode.contains(e.target)) {
        popup.classList.add('gdp-hidden');
      }
    });

    /* expose state getter for age calculations */
    visibleInput._gedcomState = s;
  }

  /* ── age display helper ──────────────────────────────────────────── */
  function updateAgeDisplay() {
    const ageEls = document.querySelectorAll('[data-age-from][data-age-to]');
    ageEls.forEach(function (el) {
      const fromId = el.getAttribute('data-age-from');
      const toId = el.getAttribute('data-age-to');
      const fromInp = document.getElementById(fromId);
      const toInp = document.getElementById(toId);
      if (fromInp && toInp && fromInp._gedcomState && toInp._gedcomState) {
        el.textContent = calcAge(fromInp._gedcomState, toInp._gedcomState);
      }
    });
  }

  /* ── init ────────────────────────────────────────────────────────── */
  function init() {
    document.querySelectorAll('input.gedcom-date').forEach(attachPicker);
    document.addEventListener('change', updateAgeDisplay);
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }

  /* expose for manual use */
  window.GedcomDatePicker = { calcAge: calcAge };
})();
