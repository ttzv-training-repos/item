$(document).ready( function () {
    let templateData = null
    $.get("/item/mails/templates_data", function (data) {
        console.log("response")
        console.log(data)
        templateData = data.template_data
    });
    $('.template-entry-content').click(function (entry) {
        let selectedTemplate = this.getAttribute('data-template-id');
        console.log(selectedTemplate);
        templateContent = templateData[selectedTemplate].content;
        templateTags = templateData[selectedTemplate].tags;
        setMessageContent(templateContent);
        renderInputsForTemplateTags(templateTags);
    });
});

function setMessageContent(content) {
    let mailText = document.querySelector(".mail-text")
    mailText.innerHTML = content
}

function renderInputsForTemplateTags(tags){
    let varialbeInputList = document.querySelector('.variables')
    varialbeInputList.innerHTML = ''
    tags.forEach(tag => {
        varialbeInputList.innerHTML += variableInputHtml(tag)
    })
}

function variableInputHtml(id){
    return `
            <div class="labeled-input normalized-transition">
                <label for="${id}">${id}</label>
                <input type="text" name="${id}" id="${id}">
            </div>
        `;
}

