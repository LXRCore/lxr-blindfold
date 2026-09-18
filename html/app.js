/* LXR-BLINDFOLD — the dark | © 2026 iBoss21 / LXRCore */
(function () {
  const dark = document.getElementById('dark'), hint = document.getElementById('hint');
  let L = {}, timer = null;
  const t = (k) => L[k] || k.split('.').pop().replace(/_/g, ' ');
  function applyLocale() { document.querySelectorAll('[data-l]').forEach(el => { const k = 'ui.' + el.dataset.l; if (L[k]) el.textContent = L[k]; }); }
  window.addEventListener('message', e => {
    const m = e.data || {};
    if (m.brand && m.brand.theme) document.documentElement.dataset.theme = m.brand.theme;
    if (m.locale) { L = m.locale; applyLocale(); }
    if (m.lang) document.body.classList.toggle('lang-ka', m.lang === 'ka');
    if (m.action === 'on') { dark.classList.remove('lxr-hidden'); hint.textContent = ''; clearTimeout(timer); if (m.selfAfter > 0) timer = setTimeout(() => { hint.textContent = t('ui.self_hint'); }, m.selfAfter); }
    if (m.action === 'off') { dark.classList.add('lxr-hidden'); clearTimeout(timer); }
  });
  if (window.__LXR_MOCK__) window.postMessage(window.__LXR_MOCK__, '*');
})();
