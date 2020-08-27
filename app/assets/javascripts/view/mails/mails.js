let templateViewBuilder = new TemplateViewBuilder(null);
let messageContainer = new PreparedMessageContainer('temporary@mail');

$(document).ready( function () {
    $.get("/item/mails/templates_data", function (data) {
        console.log(data);
        templateViewBuilder.templateData = data.template_data;
    });
   
    templateViewBuilder.build();

    $('#send-request').click(() => {
        MailingAJAXRequest.sendMails();
        let progress = 0;
        let interval = setInterval(() => {
            MailingAJAXRequest.progress().done(function(data){
                progress = data.progress;
                templateViewBuilder.setProgress(data.progress);
                console.log(data)
            });
            if (progress == 100) clearInterval(interval);
        }, 100);

    });

});









