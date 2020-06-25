function reloadHolder(){
    $(document).ready(function(){
        let badge = document.querySelector('.badge');

        $.get('/item/user_holders/qty', function(data){
            badge.textContent = data["qty"]
        });
        $.get('/item/user_holders/content', function(data) {
            data["holder"].forEach(element => {
                $("#holder-entries-popup").append(`<li>${element}</li>`)
            });
        });
    });
}
