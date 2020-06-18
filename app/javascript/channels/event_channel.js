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
        console.log("updated");
        invitesContainer.innerHTML = data // called when data is broadcast in the cable
        cleanInputBox();
      },
    });
  }
}

export { initEventCable };
