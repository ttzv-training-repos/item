class TemplateEditor{

    constructor(){

    }

    build(){
        this.selectElements();
        this.handleListsAction();
        this.stopDropdownFormPropagation();
        this.handleUpdatePreview();
        this.updatePreview();
    }

    selectElements(){
        this.selectedTagList = document.getElementById('selectedTags');
        this.$templateTextArea = $('#template_content');
        this.$contentPreview = $('#content_preview');
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

    handleUpdatePreview(){
        this.$templateTextArea.on('change input',() => {
            this.updatePreview();
        })
    }

    updatePreview(){
        this.$contentPreview.html( $.parseHTML( this.$templateTextArea.val() ) );
    }
}