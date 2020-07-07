function updateHolder(data){
    let badge = document.querySelector('.badge');
    badge.textContent = data.length;
    if (data.length > 0)
    data.forEach(element => {
        $("#holder-entries-popup").append(`<li>${element.displayname},${element.name},${element.name_2}</li>`)
    });
    else {
        $("#holder-entries-popup").empty();
    }
}
