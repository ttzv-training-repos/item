function updateHolder(data){
    let badge = document.querySelector('.badge');
    badge.textContent = data.length;
    if (data.length > 0){
        for (let index = 0; index < data.length; index++) {
            element = data[index]
            let entry = document.createElement('li')
            entry.addEventListener('click',() => {
                User.current = data[index];
                updateInputValues()
            })
            entry.textContent = `${element.displayname},${element.name},${element.name_2}`
            $("#holder-entries-popup").append(entry);
            
        }
    }
    else {
        $("#holder-entries-popup").empty();
    }
}
