const initArrowChange = () => {

  const input = document.querySelectorAll('.icon-field')
  input.addEventListener("keypress")

  input.forEach((value) =>{
    const content = console.log(value.value);
    if (content != ""){
      console.log("success")
    } else {
      console.log("not a success")
    }

  });
}

export {initArrowChange}
