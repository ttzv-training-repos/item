$('.tmsg-list').toggleClass('invisible');
let templateViewBuilder = null;
let messageContainer = new PreparedMessageContainer('temporary@mail');

$(document).ready( function () {
    
    if( $('body').attr('class') == 'mails index'){
        MailingAJAXRequest.templateData().done(function buildTemplateView(data){
            templateViewBuilder = new TemplateViewBuilderV2(data.template_data);
            templateViewBuilder.build();
            $('.tmsg-list').toggleClass('invisible');
        })
    }
   
    $('#send-request').click(() => {
        MailingAJAXRequest.sendMails();
    });

});









