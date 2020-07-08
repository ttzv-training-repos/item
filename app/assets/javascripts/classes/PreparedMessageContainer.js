class PreparedMessageContainer{

    constructor(sender){
        this.preparedMessages = new Array()
        this.sender = sender
        this.requestHash = {
            sender: this.sender,
            messages: this.preparedMessages
        }
    }

    addMessage(mail){
        this.preparedMessages.push(mail)
    }

    setSender(sender){
        this.requestHash.sender = sender
    }

    getHash(){
        return {message_request: this.requestHash}
    }

    getMessage(template, user){
    }

}