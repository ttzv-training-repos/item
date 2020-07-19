class Mail{

    constructor(template, user){
        this.template = template
        this.user = user
        this.tagParams = this.genTagParams();
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
        this.hash.params[tagName] = value
    }

    getTagValue(tagName){
        return this.hash.params[tagName];
    }

    updateTemplateContent(){
        let element = this.DOMElement(this.template.content);
        let tagMap = new Map(Object.entries(this.tagParams))
        tagMap.forEach((value, key) => {
            let content = value;
            if (content === "default"){
                content = getDefaultInputValue(key, this.template, this.user)
            }
            console.log(content)
            let tag = element.querySelector(key)
            $(tag).text(content);
        });
        console.log(element)
        this.template.content = element.innerHTML;
    }
    
    equals(other){
        if (this.template === other.template && this.user === other.user){
            return true;
        } else {
            return false;
        }
    }

    DOMElement(content){
        let element = document.createElement('element');
        element.innerHTML = content
        return element;
    }
}

