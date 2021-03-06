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
            user_id: this.user.ad_users_id,
            recipient: this.user.ad_users_mail,
            phone_number: this.user.ad_user_details_phonenumber,
            template_id: this.template.id,
            name: this.template.name,
            subject: this.template.title,
            content: this.content,
            tagMap: Object.fromEntries(this.tagMap)
        }
    }

    assignTagBindings(){
        let tags = this.template.tags;
        tags.forEach(tag => {
            let value = "" 
            value = this.itemtagValue(tag);
            this.setTagValue(tag.name, value);
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

    itemtagValue(tag){
        if (this.user) {
            if ( tag.override_default_mask ){
                return tag.custom_mask_values[this.user.ad_users_id];
            } else {
                return tag.default_mask_values[this.user.ad_users_id];
            }
        }
    }
}

