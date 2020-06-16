import consumer from "./consumer";

const initEventCable = () => {
  console.log('connected!');
  const invitesContainer = document.getElementById('invite-container');
  if (invitesContainer) {
    const id = invitesContainer.dataset.eventId;

    consumer.subscriptions.create({ channel: "EventChannel", id: id }, {
      received(data) {
        invitesContainer.innerHTML = data // called when data is broadcast in the cable
      },
    });
  }
}

export { initEventCable };
