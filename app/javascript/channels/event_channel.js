import consumer from "./consumer";

const cleanInputBox = () => {
  console.log('cleanInputBox');
  const emailInputForm = document.querySelector('.email-input-form');
  emailInputForm.value = '';
}

const initEventCable = () => {
  console.log('eventCable');
  const invitesContainer = document.getElementById('invite-container');
  if (invitesContainer) {
    const id = invitesContainer.dataset.eventId;
    consumer.subscriptions.create({ channel: "EventChannel", id: id }, {
      received(data) {
        invitesContainer.innerHTML = data // called when data is broadcast in the cable
        document.body.insertAdjacentHTML('afterend', `<div class="alert alert-info alert-dismissible" role="alert">
          <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span></button>
          Your invitation has been sent!
        </div>`);
        
        cleanInputBox();

      },
    });
  }
}
export { initEventCable };
