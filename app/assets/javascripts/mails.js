let templateData = null;
let messageContainer = new PreparedMessageContainer('helpdesk@atal.local');
$(document).ready( function () {
    $.get("/item/mails/templates_data", function (data) {
        console.log("response");
        console.log(data);
        templateData = data.template_data;
    });
    $('.template-entry-content').click(function (entry) {
        let selectedTemplate = this.getAttribute('data-index');
        console.log(selectedTemplate);
        changeToTemplateView(selectedTemplate);
    });
    attachListenersToCheckboxes();
    $('#send-request').click(function () {
        // $.post("/item/mails/send_request", messageContainer.getJson(),
        //     function (data, textStatus, jqXHR) {
        //         console.log("mailreq")
        //     },
        //     "json"
        // );
        console.error("AJAX POST invoked by this button was disabled, check mails.js file line 15")
    });
});

function setMessageContent(content) {
    let mailText = document.querySelector(".mail-text")
    mailText.innerHTML = content
}

function renderInputsForTemplateTags(tags){
    let variableInputList = document.querySelector('.variables')
    variableInputList.innerHTML = ''
    tags.forEach(tag => {
        variableInputList.innerHTML += variableInputHtml(tag.name)
    })
}

function variableInputHtml(id){
    return `
            <div class="labeled-input normalized-transition">
                <label for="${id}">${id}</label>
                <input class="varinp" type="text" name="${id}" id="${id}">
            </div>
        `;
}

function changeToTemplateView(selectedTemplate) {
    Template.current = templateData[selectedTemplate];
    templateContent = templateData[selectedTemplate].content;
    templateTags = templateData[selectedTemplate].tags;
    templateTitle = templateData[selectedTemplate].title;
    setTitle(templateTitle);
    setMessageContent(templateContent);
    renderInputsForTemplateTags(templateTags);
    templateTags.forEach(tag => { attachListenerToInput(tag.name) });
    updateInputValues();
}

function attachListenerToInput(inputIdTag) {
    let $input = $(`#${inputIdTag}`)
    $input.on('input change paste keyup', function() {
        var $str = $input.val();
        $(inputIdTag).text($str);
        updatePreparedMessageParam(inputIdTag, $str)
    });
}

function setTitle(title) {
    $('#topic').text(title)
}

function updateInputValues(){
    let varInputs = document.querySelectorAll('.varinp');
    varInputs.forEach(input => {
        let inputId = input.getAttribute('id')
        let value = getInputValue(inputId);
        input.value = value;
        $(inputId).text(value);
    });
}

function attachListenersToCheckboxes(){
    let checkboxes = document.querySelectorAll("[data-type='template-checkbox']");
    checkboxes.forEach(checkbox => {
        checkbox.addEventListener('click',function() {
            let selectedTemplate = checkbox.getAttribute('id');
            let template = templateData[selectedTemplate];
            if(checkbox.checked){
                addMessagesToContainer(template)
            } else {
                removeMessagesFromContainer(template)
            }
        })
    })
}

function getInputValue(inputId){
    let value = getCustomInputValue(inputId);
    if (value === 'default'){
        value = getDefaultInputValue(inputId, Template.current, User.current);
    }
    return value;
}

function getCustomInputValue(inputId){
    let message = getCurrentMessage();
    return message.getTagValue(inputId);
}

function getDefaultInputValue(inputId, template, user){
    let attributeValue = null;
    template.tags.forEach(tag => {
        if (tag.name === inputId && tag.bound_attr != null){
            let attr = tag.bound_attr.split('.')[1];
            attributeValue = user[attr];
        }
    });
    return attributeValue
}

function addMessagesToContainer(template){
    User.all.forEach(user => {
        let mail = new Mail(template, user);
        messageContainer.addMessage(mail);
    });
}

function removeMessagesFromContainer(template){
    User.all.forEach(user => {
        let mail = new Mail(template, user);
        messageContainer.removeMessage(mail);
    });
}

function updatePreparedMessageParam(tag, value){
    let message = getCurrentMessage();
    message.setTagValue(tag, value);
}

function getCurrentMessage(){
    return messageContainer.getMessage(Template.current, User.current);
}



