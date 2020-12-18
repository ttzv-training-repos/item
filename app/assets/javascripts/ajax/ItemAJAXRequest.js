class ItemAJAXRequest {

    static templateData(options){
        if (options.requestFor === "mail"){
            return $.get("/item/templates?category=mail", function (data) {
                console.log(data);
            }, "json");
        }
        if (options.requestFor === "sms")
        {
            return $.get("/item/templates?category=sms", function (data) {
                console.log(data);
            }, "json");
        }
        if (options.requestFor === "signature")
        {
            return $.get("/item/templates?category=signature", function (data) {
                console.log(data);
            }, "json");
        }
    }

    static sendMails(){
        $.ajax({
            type: "POST",
            url: "/item/mails/send_request",
            data: messageContainer.getJson(),
            success: function(data){
                console.log("mailreq"); 
            }
        });
    }

    static sendSMS(){
        $.ajax({
            type: "POST",
            url: "/item/sms_gateway/send_request",
            data: messageContainer.getJson(),
            success: function(data){
                console.log("smsreq");   
            }
        });
    }

    static sendSignature(){
        $.ajax({
            type: "POST",
            url: "/item/signatures/send_request",
            data: messageContainer.getJson(),
            success: function(data){
                console.log("signaturereq");   
            }
        });
    }

    static sendCartRequest(data){
        return $.ajax({
            type: "POST",
            url: "/item/user_holders",
            data: data,
            success: function(data){
                console.log("cart");   
            }
        });
    }
}