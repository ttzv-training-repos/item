function updateHolder(data){
    let badge = document.querySelector('.badge');
    badge.textContent = data.length;
    if (data.length > 0){
        for (let index = 0; index < data.length; index++) {
            element = data[index]
            let entry = document.createElement('li')
            entry.addEventListener('click',() => {
                User.current = data[index];
                templateViewBuilder.updateInputValues();
            })
            entry.textContent = `${element.ad_users_displayname}`
            $("#holder-entries-popup").append(entry);
        }
    }
    else {
        $("#holder-entries-popup").empty();
    }
}
