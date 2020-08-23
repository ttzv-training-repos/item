class TemplateViewBuilder {

    constructor(jsonTemplateData=null){
        this._templateData = jsonTemplateData;
    }

    set templateData(data){
        this._templateData = data
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
        return `
                <div class="labeled-input normalized-transition">
                    <label for="${id}">${id}</label>
                    <input type="text" name="${id}" id="${id}" data-input="varinp">
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
                    this.addMessagesToContainer(template)
                } else {
                    this.removeMessagesFromContainer(template)
                }
            })
        })
    }

    addMessagesToContainer(template){
        User.all.forEach(user => {
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

    build(){
        this.templateSelectionHandler();
        this.attachListenersToCheckboxes();
    }
}