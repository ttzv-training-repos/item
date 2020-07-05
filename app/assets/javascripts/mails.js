let templateData = null
$(document).ready( function () {
    $.get("/item/mails/templates_data", function (data) {
        console.log("response")
        console.log(data)
        templateData = data.template_data
    });
    $('.template-entry-content').click(function (entry) {
        let selectedTemplate = this.getAttribute('data-template-id');
        changeToTemplateView(selectedTemplate);
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
        variableInputList.innerHTML += variableInputHtml(tag)
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

function changeToTemplateView(selectedTemplate) {
    console.log(selectedTemplate);
    templateContent = templateData[selectedTemplate].content;
    templateTags = templateData[selectedTemplate].tags;
    setMessageContent(templateContent);
    renderInputsForTemplateTags(templateTags);
    templateTags.forEach(tag => { attachListenerToInput(tag) });
}

function attachListenerToInput(inputIdTag) {
    let $input = $(`#${inputIdTag}`)
    $input.on('input', function() {
        var $str = $input.val()
        $(inputIdTag).text($str)
    });
}

