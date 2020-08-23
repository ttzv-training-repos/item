let templateViewBuilder = new TemplateViewBuilder(null);
let messageContainer = new PreparedMessageContainer('temporary@mail');

$(document).ready( function () {
    $.get("/item/mails/templates_data", function (data) {
        console.log(data);
        templateViewBuilder.templateData = data.template_data;
    });
   
    templateViewBuilder.build();

    $('#send-request').click(function () {
        // $.post("/item/mails/send_request", messageContainer.getJson(),
        //     function (data, textStatus, jqXHR) {
        //         console.log("mailreq")
        //     },
        //     "json"
        // );
        console.error("AJAX POST invoked by this button was disabled, check mails.js file line 22")
    });
});









