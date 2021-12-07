import consumer from "./consumer";

const initChatroomCable = () => {
  const messageInput = document.getElementById("message_content");
  const messagesContainer = document.getElementById('messages');
  if (messagesContainer) {
    const id = messagesContainer.dataset.chatroomId;

    consumer.subscriptions.create({ channel: "ChatroomChannel", id: id }, {
      received(data) {
        console.log(data);
        messagesContainer.insertAdjacentHTML('beforeend', data);
        // called when data is broadcast in the cable
        messageInput.innerHTML= "";
      }
    });
  }
}

export { initChatroomCable };
