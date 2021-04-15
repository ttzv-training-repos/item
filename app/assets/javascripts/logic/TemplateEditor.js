class TemplateEditor{

    constructor(){

    }

    build(){
        this.selectElements();
        this.handleListsAction();
        this.stopDropdownFormPropagation();
    }

    selectElements(){
        this.selectedTagList = document.getElementById('selectedTags');
        this.$templateTextArea = $('#template_content');
    }

    handleListsAction(){
        this.selectedTagList.addEventListener('click', (e) => {
            let item = e.target;
            let tagName = item.dataset.tagName;
            if(tagName){
                this.handleTagInsert(tagName);
            }
        });
    }

    handleTagInsert(tagName){
        this.$templateTextArea[0].focus();
        document.execCommand('insertText', false, this.asTag(tagName));
    }

    asTag(tagName){
        return `<${tagName}></${tagName}>`
    }

    stopDropdownFormPropagation(){
        $('#tagNewForm').on('click', function (event) {
            event.stopPropagation();
            console.log(event);
        });
    }
}