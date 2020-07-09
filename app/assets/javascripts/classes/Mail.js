class Mail{

    constructor(template, user){
        this.template = template
        this.user = user
        this.tagParams = this.tagParams();
        this.hash = this.getJson();
    }

    getJson(){
        this.hash = {
            recipient: this.user.mail,
            template: this.template,
            params: this.tagParams,
            custom: null
        }
        return this.hash;
    }

    tagParams(){
        let tags = this.template.tags
        let hash = {}
        tags.map(tag => {
            hash[tag.name] = "default"
        });
        return hash;
    }

    setRecipientAddress(address){
        this.hash.recipient = address;
    }

    setTagValue(tagName, value){
        this.hash.params[tagName] = value
    }

    getTagValue(tagName){
        return this.hash.params[tagName];
    }
    
    equals(other){
        if (this.template === other.template && this.user === other.user){
            return true;
        } else {
            return false;
        }
    }
}

