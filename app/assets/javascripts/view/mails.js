$('.tmsg-list').toggleClass('invisible');
let templateViewBuilder = null;
let messageContainer = new PreparedMessageContainer('temporary@mail');

$(document).ready( function () { 
    if( $('body').attr('class') == 'mails index'){
        ItemAJAXRequest.templateData({requestFor: "mail"}).done(function buildTemplateView(data){
            templateViewBuilder = new TemplateViewBuilderV2(data.template_data);
            templateViewBuilder.build();
            $('.tmsg-list').toggleClass('invisible');
        });
        $('#send-request').click(() => {
            ItemAJAXRequest.sendMails();
        });
    }

    if( $('body').attr('class') == 'sms_gateway index'){
        ItemAJAXRequest.templateData({requestFor: "sms"}).done(function buildTemplateView(data){
            templateViewBuilder = new TemplateViewBuilderV2(data.template_data);
            templateViewBuilder.build();
            $('.tmsg-list').toggleClass('invisible');
        });
        $('#send-request').click(() => {
            ItemAJAXRequest.sendSms();
        });
    }

    if( $('body').attr('class') == 'signatures index'){
        ItemAJAXRequest.templateData({requestFor: "signature"}).done(function buildTemplateView(data){
            templateViewBuilder = new TemplateViewBuilderV2(data.template_data);
            templateViewBuilder.build();
            $('.tmsg-list').toggleClass('invisible');
        });
        $('#send-request').click(() => {
            ItemAJAXRequest.sendSignature();
        });
    }  
});









