class Mail{

    constructor(template, user){
        this.template = template
        this.user = user
        this.tagParams = this.genTagParams();
    }

    getJson(){
        return {
            recipient: this.user.mail,
            template: this.template.content
        }
    }

    genTagParams(){
        let tags = this.template.tags
        let tagHash = {}
        tags.map(tag => {
            tagHash[tag.name] = "default"
        });
        return tagHash;
    }

    setRecipientAddress(address){
        this.hash.recipient = address;
    }

    setTagValue(tagName, value){
        this.tagParams[tagName] = value
    }

    getTagValue(tagName){
        return this.tagParams[tagName];
    }
    
    equals(other){
        if (this.template === other.template && this.user === other.user){
            return true;
        } else {
            return false;
        }
    }
}

