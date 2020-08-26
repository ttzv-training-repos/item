class TemplateViewBuilder {

    constructor(jsonTemplateData=null){
        this._templateData = jsonTemplateData;
        this._recipients = new Array();
    }

    inputSenderHandler(){
        $("input[data-event]").on('input change paste keyup', (e) => {
            messageContainer.sender = $("input[data-event]").val();
        });
    }

    set templateData(data){
        this._templateData = data;
    }
    get recipients(){
        return this._recipients;
    }
    
    templateSelectionHandler(){
        let templateEntries = document.querySelectorAll('.template-entry-content')
        templateEntries.forEach(templateEntry => {
            templateEntry.addEventListener('click', (entry) => {
                let selectedTemplate = entry.target.getAttribute('data-index');
                console.log(selectedTemplate);
                this.changeToTemplateView(selectedTemplate);
            })
        });
    }

    changeToTemplateView(selectedTemplate) {
        Template.current = this._templateData[selectedTemplate];
        let templateContent = this._templateData[selectedTemplate].content;
        let templateTags = this._templateData[selectedTemplate].tags;
        let templateTitle = this._templateData[selectedTemplate].title;
        this.setTitle(templateTitle);
        this.setMessageContent(templateContent);
        this.renderInputsForTemplateTags(templateTags);
        templateTags.forEach(tag => { this.attachListenerToInput(tag.name) });
        this.updateInputValues();
    }

    setTitle(title) {
        $('#topic').text(title)
    }

    setMessageContent(content) {
        let mailText = document.querySelector(".mail-text")
        mailText.innerHTML = content
    }

    renderInputsForTemplateTags(tags){
        let variableInputList = document.querySelector('.variables')
        variableInputList.innerHTML = ''
        tags.forEach(tag => {
            variableInputList.innerHTML += this.variableInputHtml(tag.name)
        })
    }

    attachListenerToInput(inputIdTag) {
        let $input = $(`#${inputIdTag}`)
        $input.on('input change paste keyup', () => {
            var $str = $input.val();
            $(inputIdTag).text($str);
            this.updatePreparedMessageParam(inputIdTag, $str)
        });
    }

    updateInputValues(){
        let varInputs = document.querySelectorAll("[data-input='varinp']");
        varInputs.forEach(input => {
            let inputId = input.getAttribute('id')
            let value = this.getInputValue(inputId);
            input.value = value;
            $(inputId).text(value);
        });
    }

    variableInputHtml(id){
        let label = id.split('-')[2];
        return `
                <div class="form__group field">
                    <input type="input" class="form__field" name="${id}" id="${id}" data-input="varinp" placeholder="${label}" required>
                    <label for="${id}" class="form__label">${label}</label>
                </div>
            `;
    }

    getInputValue(inputId){
        return this.getCurrentMessage().getTagValue(inputId);
    }
    
    updatePreparedMessageParam(tag, value){
        let message = this.getCurrentMessage();
        message.setTagValue(tag, value);
    }
    
    getCurrentMessage(){
        return messageContainer.getMessage(Template.current, User.current);
    }

    attachListenersToCheckboxes(){
        let checkboxes = document.querySelectorAll("[data-type='template-checkbox']");
        checkboxes.forEach(checkbox => {
            checkbox.addEventListener('click',() => {
                let selectedTemplate = checkbox.getAttribute('id');
                let template = this._templateData[selectedTemplate];
                if(checkbox.checked){
                    this.addMessagesToContainer(template, User.all)
                } else {
                    this.removeMessagesFromContainer(template)
                }
            })
        })
    }

    addMessagesToContainer(template, users){
        users.forEach(user => {
            let mail = new Mail(template, user);
            messageContainer.addMessage(mail);
        });
    }
    
    removeMessagesFromContainer(template){
        User.all.forEach(user => {
            let mail = new Mail(template, user);
            messageContainer.removeMessage(mail);
        });
    }

    updateRecipientsDropdown(){
        User.all.forEach(user => {
            let mail = user.ad_users_mail;
            this.addNewRecipient(mail);
        });
    }

    buildNewRecipientHandler(){
        let emailInput = document.querySelector('#emailAddress');
        $('button[data-jsevent]').click(() => {
            if (emailInput.checkValidity() ){
                let mail = emailInput.value;
                this.addNewRecipient(mail);
            }
        });
    }

    addNewRecipient(mail){
        if(!this._recipients.includes(mail) && mail.length > 0){
            if (!User.all.map(u => u.ad_users_mail).includes(mail)){
                let user = {ad_users_mail: mail}
                User.all.push(user)
                if (Template.current) this.addMessagesToContainer(Template.current, [user])
            }
            this._recipients.push(mail);
            $('#recipientsDropdown').prepend(this.buildDropdownItem(mail));
            $('#recipients-no').text(this._recipients.length);
        }
    }

    buildDropdownItem(content){
        let dropdownItem = document.createElement('div');
        dropdownItem.classList.add("dropdown-item");
        dropdownItem.textContent = content;
        dropdownItem.addEventListener('click', () => {
            User.current = User.all.filter(u => u.ad_users_mail == content)[0];
            this.updateInputValues();
        })
        return dropdownItem;
    }


    build(){
        this.inputSenderHandler();
        this.templateSelectionHandler();
        this.attachListenersToCheckboxes();
        this.buildNewRecipientHandler();
    }

}