const initArrowChange = () => {

  const fieldEls = document.querySelectorAll('.icon-field')

  fieldEls.forEach((fieldEl) => {
    const inputEl = fieldEl.querySelector('input, select');
    const onFieldChange = () => {
      console.log(inputEl.value);
      fieldEl.classList.toggle('icon-field-complete', inputEl.value.length > 0);
    }
    // console.log(inputEl)
    inputEl.addEventListener("change", onFieldChange);
    inputEl.addEventListener("keyup", onFieldChange);
    fieldEl.addEventListener("click", onFieldChange);
  });
}

export {initArrowChange}
