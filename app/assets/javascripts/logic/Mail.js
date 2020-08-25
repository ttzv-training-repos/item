class Mail extends Message{

    constructor(template, user){
        super(template, user);
        this.template = template;
        this.content = template.content;
        this.user = user;
        this.tagMap = new Map();
        this.assignTagBindings();
    }

    getJson(){
        return {
            recipient: this.user.ad_users_mail,
            subject: this.template.title,
            content: this.content
        }
    }

    assignTagBindings(){
        let tags = this.template.tags;
        tags.forEach(tag => {
            let value = this.user[tag.bound_attr] ?? "" 
            this.setTagValue(tag.name, value)
        });
        this.updateContent();
    }

    setTagValue(tagName, value){
        this.tagMap.set(tagName, value);
        this.updateContent();
    }

    getTagValue(tagName){
        return this.tagMap.get(tagName);
    }

    updateContent(){
        this.tagMap.forEach((tagValue, tagKey) => {
            let regexp = new RegExp(`(?<=<${tagKey}>)(.*?)(?=<\/${tagKey}>)`, 'g');
            this.content = this.content.replace(regexp, tagValue);
        });
    }
    
    equals(other){
        if (this.template === other.template && this.user === other.user){
            return true;
        } else {
            return false;
        }
    }
}

