$('.template-list').toggleClass('invisible');
let templateViewBuilder = null;
let messageContainer = new PreparedMessageContainer('temporary@mail');

$(document).ready( function () {
    
    MailingAJAXRequest.templateData().done(function buildTemplateView(data){
        templateViewBuilder = new TemplateViewBuilderV2(data.template_data);
        templateViewBuilder.build();
        $('.template-list').toggleClass('invisible');
    })
   
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









