$(document).ready( function () {
    if( $('body').attr('class') !== 'mails index'){
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