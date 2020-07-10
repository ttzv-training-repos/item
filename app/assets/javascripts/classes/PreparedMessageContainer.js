class PreparedMessageContainer{

    constructor(sender){
        this.preparedMessages = new Array();
        this.sender = sender;
        this.requestHash = this.updateRequestJson();
    }

    addMessage(mail){
        if(!this.includes(mail)){
            this.preparedMessages.push(mail);
        }
    }

    addMessages(mails){
        mails.forEach(element => {
            this.addMessage(element);
        });
    }

    removeMessage(message){
        this.preparedMessages = this.preparedMessages.filter( msg => !msg.equals(message));
        this.updateRequestJson();
    }

    setSender(sender){
        this.requestHash.sender = sender;
    }

    getJson(){
        this.updateRequestJson();
        return {message_request: this.requestHash};
    }

    getMessage(template, user){
        let mail = new Mail(template, user)
        return this.preparedMessages.filter( msg => msg.equals(mail))[0]; //should ever be only one unless something goes horribly wrong
    }

    updateRequestJson(){
        this.requestHash = {
            sender: this.sender,
            messages: this.getMessageHashArray()
        }
    }

    includes(object){
        return this.indexOf(object) !== -1;
    }

    indexOf(object){
        if (!object instanceof Mail){
            throw TypeError('Can only compare Message objects')
        }

        let index = -1;

        for (let index = 0; index < this.preparedMessages.length; index++) {
            const msg = this.preparedMessages[index];
            if(object.equals(msg)) return index;
        }
        return index;
    }

    getMessageHashArray(){
        return this.preparedMessages.map(msg => msg.getJson());
    }

}