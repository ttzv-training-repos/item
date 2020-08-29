function updateHolder(data){
    let badge = document.querySelector('#cartQty');
    badge.textContent = data.length;
    if (data.length > 0){
        let entries = new Array();
        for (let index = 0; index < data.length; index++) {
            element = data[index];
            let entry = document.createElement('div');
            entries.push(entry);
            entry.classList.toggle('list-group-item');
            entry.dataset.toggle = "list"
            entry.addEventListener('click',() => {
                User.current = data[index];
                templateViewBuilder.renderInputsForTemplateTags(Template.current.tags);
            })
            entry.textContent = `${element.ad_users_displayname}`
            $("#holder-entries-popup").append(entry);
        }
        entries[0].classList.toggle('active')
    }
    else {
        $("#holder-entries-popup").empty();
    }
}
