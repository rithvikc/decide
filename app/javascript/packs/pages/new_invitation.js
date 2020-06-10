const friendsListEl = document.querySelector('.list-friends');
const addFriendBtnEl = document.querySelector('.js-add-friend-btn');
const friendEmailEl = document.getElementById("friend-email");
const friendEmails = ['john@gmail.com'];
const friendEmailValueEl = document.querySelector('.js-friends-value');

const renderTags = () => {
  friendsListEl.innerHTML = '';
  friendEmails.forEach ( (friendEmail) => {
    const tagEL = document.createElement("div");
    tagEL.innerHTML = friendEmail;
    friendsListEl.appendChild(tagEL);
    tagEL.addEventListener("click", (event) =>{
      const friendEmailIndex = friendEmails.indexOf(friendEmail);
      friendEmails.splice(friendEmailIndex, 1);
      renderTags();
    });
  });
  friendEmailValueEl.value = friendEmails.join();
}


renderTags();

addFriendBtnEl.addEventListener("click", (event) => {
  event.preventDefault();
  friendEmails.push(friendEmailEl.value);
  renderTags();
  friendEmailEl.value = '';
});

