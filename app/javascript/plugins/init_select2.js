const initSelect2 = () => {
  const selectEls = document.querySelectorAll('select');
  if (selectEls) {
    selectEls.forEach((selectEl) =>{
      window.jQuery(selectEl).select2({
        width: '100%',
        placeholder: selectEl.dataset.placeholder
      });
    })
  }
}
export { initSelect2 };
