class MailingAJAXRequest {

    static templateData(){
        return $.get("/item/mails/templates_data", function (data) {
            console.log(data);
        });
    }

    static sendMails(){
        $.ajax({
            type: "POST",
            url: "/item/mails/send_request",
            data: messageContainer.getJson(),
            success: function(data){
                console.log("mailreq")   
            }
        });
        //console.error("AJAX POST invoked by this button was disabled, check mails.js file line 22")
    }

    static progress(){
        return $.ajax({
                type: "POST",
                url: "/item/mails/progress",
                data: {},
                success: function(data){
                    
                }
            });
    }
    

}