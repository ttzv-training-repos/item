if( $('body').attr('class') == 'settings index'){
    $(document).ready( function () {
        const $gmailApiCheckbox = $("#use_gmail_api");
        const $gmailApiSubmit = $("#gmailApiSubmit");
        const $smtpForm = $("#smtpSettingsForm");

        if ($gmailApiCheckbox[0].checked){
            $smtpForm.addClass("d-none");
        } else {
            $gmailApiSubmit.addClass("d-none");
        }
        $gmailApiCheckbox.on("change", () => {
            if ($gmailApiCheckbox[0].checked){
                $smtpForm.addClass("d-none");
                $gmailApiSubmit.removeClass("d-none");
            } else {
                $smtpForm.removeClass("d-none");
                $gmailApiSubmit.addClass("d-none");
            }
        })
    });
}