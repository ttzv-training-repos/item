$(document).ready( function () {
    if( $('body').attr('class') !== 'mails index' &&
    $('body').attr('class') !== 'sms_gateway index' &&
    $('body').attr('class') !== 'signatures index'){
        ItemAJAXRequest.sendCartRequest({
            cart_request: {
                action: "content",
                data: null
            }
        }).done(function proceed(data){
            handleResponse(data);
        });
    }
});