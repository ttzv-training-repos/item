class TemplateViewBuilderV2{
    constructor(templateData, view=null){
        if (!templateData) throw new Error("Template Data cannot be null, failed to create object") 
        this._templateData = templateData;
        this._recipients = new Array();
        this._selectedTemplates = new Array();
        this.queryTemplateViewElements();
        messageContainer.sender = this.$inputSender.val();
        this.noSelectedTemplates = 0;
        this.view = view;
    }

    queryTemplateViewElements(){
        this.$inputSender = $('#sender');
        this.$buttonDropdownMenu = $('#buttonDropdownMenu');
        this.$buttonAddRecipient = $('#buttonAddRecipient');
        this.$inputRecipientAddress = $('#inputRecipientAddress');
        this.$inputsArea = $('#inputsArea')
        this.$title = $('#title');
        this.$content = $('#content')
        this.$noSelectedTemplates = $('#noSelectedTemplates');
        this.templateEntries = document.querySelectorAll('[data-entry-area]')
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
        let inputGroup = document.createElement("div");
        let input = document.createElement("input");
        input.type = "input";
        input.classList = "form-control";
        input.id = name;
        input.name = name;
        input.placeholder = label;
        input.required = true;
        inputGroup.classList = "input-group mb-3";
        inputGroup.appendChild(input);

        return inputGroup;
    }

    inputAppendix(){
        let appendix = document.createElement("div");
        appendix.classList = "input-group-append";
        
        let content = document.createElement("div");
        content.classList = "input-group-text";
        content.title = "This value will be stored";
        
        let saveIcon = document.createElement("i");
        saveIcon.classList = "fas fa-save";
        content.appendChild(saveIcon);
        appendix.appendChild(content);
        return appendix;
    }

    renderInputsForTemplateTags(tags){
        this.$inputsArea.html('')
        tags.forEach(tag => {
            let tagInput = this.templateInput(tag.name);
            if(tag.store_value) tagInput.append(this.inputAppendix());
            this.$inputsArea.append(tagInput);
            let $input = $(`#${tag.name}`);
            $input.val(this.getCurrentMessageTagValue(tag.name));
            this.updateTemplatePreview($input);
            this.handleTemplateInput($input);
        })
    }

    handleTemplateInput($input){
        $input.on('input paste', () => {
            this.updateTemplatePreview($input);
            this.setCurrentMessageTagValue($input.attr('id'), $input.val())
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

    setCurrentMessageTagValue(tagName, value){
        let currentMessage = this.currentMessage();
        currentMessage.setTagValue(tagName, value)
    }

    handleNewRecipient(){
        this.$buttonAddRecipient.on('click',() => {
            if(this.$inputRecipientAddress[0].checkValidity() 
            && this.$inputRecipientAddress.val().length > 0){
                let address = this.$inputRecipientAddress.val();
                let user = User.create({});
                if (this.view === "sms") {
                    user.ad_user_details_phonenumber = address;
                } else {
                    user.ad_users_mail = address;
                }
                this.addNewRecipient(user);
                this.$inputRecipientAddress.val('');
            }
        })
    }

    addNewRecipient(user){
        let address = this.getRecipientAddress(user);
        if(!this._recipients.includes(address)){
            if (!this.containsRecipient(user)){
                User.all.push(user);
                User.current = user;
                this.handleMessageContainer(this._selectedTemplates, [User.current], 'add')
            }
            this._recipients.push(address);
            $('#recipientsDropdown').append(this.buildDropdownItem(user));
            $('#recipients-no').text(this._recipients.length);
        }
    }
    
    buildDropdownItem(user){
        let dropdownItem = document.createElement('div');
        dropdownItem.classList.add("dropdown-item");
        let title = user.ad_users_displayname;
        if (title) dropdownItem.title = title;
        dropdownItem.textContent = this.getRecipientAddress(user);
        dropdownItem.addEventListener('click', () => {
            User.current = user;
            if (Template.current) this.renderInputsForTemplateTags(Template.current.tags);
        })
        return dropdownItem;
    }

    updateRecipientsDropdown(){
        User.all.forEach(user => {
            this.addNewRecipient(user);
        });
    }

    unselectAllTemplates(){
        document.querySelectorAll('[data-entry-area="checkbox"]').forEach(input => {
            if( input.checked ) input.click();
        });
    }

    getRecipientAddress(user){
        if (this.view === "sms"){
            return user.ad_user_details_phonenumber;
        } else {
            return user.ad_users_mail;
        }
    }

    // todo: implement comparator in User object
    containsRecipient(user){
        if (this.view === "sms"){
            return User.all.map(u => u.ad_user_details_phonenumber).includes(user.ad_user_details_phonenumber)
        } else {
            return User.all.map(u => u.ad_users_mail).includes(user.ad_users_mail)
        }
    }
}