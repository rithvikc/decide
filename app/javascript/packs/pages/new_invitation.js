const friendsListEl = document.querySelector('.list-friends');
const addFriendBtnEl = document.querySelector('#js-add-friend-btn');
const friendEmailEl = document.querySelector('.friend-email');
const friendEmails = [];
const friendEmailValueEl = document.querySelector('.js-friends-value');

const displayTags = () => {
  friendsListEl.innerHTML = '';
  friendEmails.forEach ( (friendEmail) => {
    const tagEL = document.createElement("div");
    tagEL.className = "notification mr-4 mb-4";
    tagEL.innerHTML = friendEmail;
    friendsListEl.appendChild(tagEL);
  });
}

addFriendBtnEl.addEventListener("click", (event) => {
  console.log("clicked");
  event.preventDefault();
  friendEmails.push(friendEmailEl.value);
  console.log(friendEmails);
  displayTags();
});

