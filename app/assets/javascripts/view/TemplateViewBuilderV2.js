class TemplateViewBuilderV2{
    constructor(templateData){
        if (!templateData) throw new Error("Template Data cannot be null, failed to create object") 
        this._templateData = templateData;
        this._recipients = new Array();
        this._selectedTemplates = new Array();
        this.queryTemplateViewElements();
        this.noSelectedTemplates = 0;
    }

    queryTemplateViewElements(){
        this.$inputSender = $('#sender');
        this.$buttonDropdownMenu = $('#buttonDropdownMenu');
        this.$buttonAddRecipient = $('#buttonAddRecipient');
        this.$inputEmailAddress = $('#inputEmailAddress');
        this.$inputsArea = $('#inputsArea')
        this.$title = $('#title');
        this.$content = $('#content')
        this.$noSelectedTemplates = $('#noSelectedTemplates');
        this.templateEntries = document.querySelectorAll('div[data-entry-area], input[data-entry-area]')
    }

    build(){
        this.handleSenderChange();
        this.handleTemplateEntryActions();
        this.updateRecipientsDropdown();
        this.handleNewRecipient();
    }

    handleTemplateEntryActions(){
        this.templateEntries.forEach(templateEntry => {
            if (templateEntry.dataset.entryArea === "content"){
                this.handleTemplatePreview(templateEntry);
            }
            if(templateEntry.dataset.entryArea === "checkbox"){
                this.handleTemplateSelection(templateEntry);
            }
            if(templateEntry.dataset.entryArea === "edit"){
                this.handleTemplateEdit(templateEntry);
            }
            if(templateEntry.dataset.entryArea === "delete"){
                this.handleTemplateDelete(templateEntry);
            }
        });
    }

    handleTemplatePreview(templateEntry){
        templateEntry.addEventListener('click', () => {
            let templateName = templateEntry.dataset.entryAreaId;
            if(this.canChangeCurrentTemplate(templateName)){
                let template = Template.current;
                this.$title.val(template.title);
                this.$content.html(template.content);
                this.renderInputsForTemplateTags(template.tags)
            }
        })    
    }

    handleTemplateSelection(templateEntryCheckbox){
        let checkbox = templateEntryCheckbox;
        checkbox.addEventListener('click', () =>{
            let templateName = checkbox.id;
            if(this.canChangeCurrentTemplate(templateName)){
                if(checkbox.checked){
                    this._selectedTemplates.push(templateName);
                    this.handleMessageContainer([templateName], User.all, 'add');
                    this.noSelectedTemplates += 1;
                }  else {
                    this.handleMessageContainer([templateName], User.all, 'delete');
                    this._selectedTemplates = this._selectedTemplates.filter(el => el !== templateName);
                    this.noSelectedTemplates -= 1;
                }
                this.$noSelectedTemplates.text(this.noSelectedTemplates);  
            }
        });
    }    

    handleTemplateEdit(templateEntry){
    }

    handleTemplateDelete(templateEntry){
    }

    handleMessageContainer(templateNames, users, action){
        if (!users) throw new Error("Users null")
        if (!templateNames) throw new Error("Templates null")
        templateNames.forEach(templateName => {
            users.forEach(user => {
                let mail = new Mail(
                    this.getTemplate(templateName), user
                    );
                if (action === 'add'){
                    messageContainer.addMessage(mail);
                }
                if (action === 'delete'){
                    messageContainer.removeMessage(mail);
                }
            });
        });
    }

    handleSenderChange(){
        this.$inputSender.on('input change paste keyup', (e) => {
            messageContainer.sender = this.$inputSender.val();
        });
    }

    set templateData(data){
        this._templateData = data;
    }

    get recipients(){
        return this._recipients;
    }

    canChangeCurrentTemplate(templateName){
        if(this._templateData[templateName]){
            let template = this._templateData[templateName];
            Template.current = template;
            return true;
        } else {
            return false;
        }
    }

    getTemplate(templateName){
        return this._templateData[templateName];
    }

    templateInput(name){
        let label = name.split('-')[2];
        return `
                <div class="form__group field">
                    <input type="input" class="form__field" name="${name}" id="${name}" placeholder="${label}" required>
                    <label for="${name}" class="form__label">${label}</label>
                </div>
            `;
    }

    renderInputsForTemplateTags(tags){
        this.$inputsArea.html('')
        tags.forEach(tag => {
            this.$inputsArea.append(this.templateInput(tag.name));
            let $input = $(`#${tag.name}`);
            $input.val(this.getCurrentMessageTagValue(tag.name));
            this.updateTemplatePreview($input);
            this.handleTemplateInput($input);
        })
    }

    handleTemplateInput($input){
        $input.on('input paste', () => {
            this.updateTemplatePreview($input);
            this.setCurrentCurrentMessageTagValue($input.attr('id'), $input.val())
        });
    }

    updateTemplatePreview($input){
        $($input.attr('id')).text($input.val());
    }

    currentMessage(){
        return messageContainer.getMessage(Template.current, User.current);
    }
    
    getCurrentMessageTagValue(tagName){
        let currentMessage = this.currentMessage();
        return currentMessage ? currentMessage.getTagValue(tagName) : ''
    }

    setCurrentCurrentMessageTagValue(tagName, value){
        let currentMessage = this.currentMessage();
        currentMessage.setTagValue(tagName, value)
    }

    handleNewRecipient(){
        this.$buttonAddRecipient.on('click',() => {
            if(this.$inputEmailAddress[0].checkValidity() 
            && this.$inputEmailAddress.val().length > 0){
                let mail = this.$inputEmailAddress.val();
                this.addNewRecipient(mail);
                this.$inputEmailAddress.val('');
            }
        })
    }

    addNewRecipient(mail){
        if(!this._recipients.includes(mail)){
            if (!User.all.map(u => u.ad_users_mail).includes(mail)){
                let user = {ad_users_mail: mail}
                User.all.push(user)
                User.current = user
                this.handleMessageContainer(this._selectedTemplates, [User.current], 'add')
            }
                this._recipients.push(mail);
                $('#recipientsDropdown').append(this.buildDropdownItem(mail));
                $('#recipients-no').text(this._recipients.length);
        }
    }
    
    buildDropdownItem(content){
        let dropdownItem = document.createElement('div');
        dropdownItem.classList.add("dropdown-item");
        dropdownItem.textContent = content;
        dropdownItem.addEventListener('click', () => {
            User.current = User.all.filter(u => u.ad_users_mail == content)[0];
            if (Template.current) this.renderInputsForTemplateTags(Template.current.tags);
            //if (Template.current) this.handleTemplatePreview(Template.current);
            //this.updateInputValues();
        })
        return dropdownItem;
    }

    updateRecipientsDropdown(){
        User.all.forEach(user => {
            let mail = user.ad_users_mail;
            this.addNewRecipient(mail);
        });
    }

}