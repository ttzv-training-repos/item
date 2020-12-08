class ItemAJAXRequest {

    static templateData(options){
        if (options.requestFor === "mail"){
            return $.get("/item/mails/templates_data", function (data) {
                console.log(data);
            });
        }
        if (options.requestFor === "sms")
        {
            return $.get("/item/sms_gateway/templates_data", function (data) {
                console.log(data);
            });
        }
        if (options.requestFor === "signature")
        {
            return $.get("/item/signatures/templates_data", function (data) {
                console.log(data);
            });
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
}