class PreparedMessageContainer{

    constructor(sender){
        this.preparedMessages = new Array();
        this._sender = sender;
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
    }

    set sender(sender){
        this._sender = sender;
    }

    getJson(){
        return {message_request: {
            sender: this._sender,
            messages: this.getMessageHashArray()
            }
        };
    }

    getMessage(template, user){
        let mail = new Mail(template, user)
        return this.preparedMessages.filter( msg => msg.equals(mail))[0]; //should ever be only one unless something goes horribly wrong
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

    getPreparedMessages(){
        return this.preparedMessages
    }

}