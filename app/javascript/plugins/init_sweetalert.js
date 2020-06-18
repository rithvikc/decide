import Swal from 'sweetalert2';

const initSweetAlert = () => {
  const btnAlert = document.querySelector('.js-sweetalert');
  if (btnAlert) {
    btnAlert.addEventListener('click', (event) => {
      event.preventDefault();
      let timerInterval
      const form = event.currentTarget.form
      Swal.fire({
        icon: 'success',
        title: 'We are thinking hard for you...',
        html: 'Narrowing down <b></b> restaurants.',
        timer: 2000,
        timerProgressBar: true,
        onBeforeOpen: () => {
          setTimeout(() => {
            form.submit()
          }, 2000)
          Swal.showLoading()
          timerInterval = setInterval(() => {
            const content = Swal.getContent()
            if (content) {
              const b = content.querySelector('b')
              if (b) {
                b.textContent = Swal.getTimerLeft()
              }
            }
          }, 100)
        },
        onClose: () => {
          clearInterval(timerInterval)
        }
      })
    })
  }
}

export { initSweetAlert }
