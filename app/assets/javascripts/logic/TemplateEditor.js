class TemplateEditor{

    constructor(){

    }

    build(){
        this.selectElements();
        this.handleListsAction();
        this.removeDuplicateSelected();
        this.modalHandler();
        this.handleNewTag();
    }

    selectElements(){
        this.selectedTagList = document.getElementById('selectedTags');
        this.availableTagList = document.getElementById('availableTags');
        this.$availableTagList = $('#availableTags');
        this.selectedTags = [...this.selectedTagList.children];
        this.availableTags = [...this.availableTagList.children];
        this.$templateTextArea = $('#template_content');
        this.templateTextArea = document.getElementById('template_content');

        this.$editTagName = $('#editTagName');
        this.$editTagDescription = $('#editTagDescription');
        this.$editTagMask = $('#editTagMask');
        this.$editTagStoreValue = $('#editTagStoreValue');
        this.$btnSaveTagEdit = $('#btnSaveTagEdit');
    }

    handleListsAction(){
        this.selectedTagList.addEventListener('click', (e) => {
            let item = e.target
            let tagName = item.dataset.tag
            if(tagName){
                this.handleTagInsert(tagName)
            }
            if(item.dataset.tagAction === "selector"){
                this.handleTagSelection(item);
            }
            if(item.dataset.tagAction === "editor"){

            }
        });
        this.availableTagList.addEventListener('click', (e) => {
            let item = e.target
            this.handleTagSelection(item);
        })
    }

    handleTagInsert(tagName){
        let taVal = this.$templateTextArea.val();
        let curPos = this.templateTextArea.selectionStart;
        this.$templateTextArea.val( taVal.slice( 0, curPos ) + this.asTag(tagName) + taVal.slice( curPos ) );
    }

    handleTagSelection(item){
        let itemParent = item.parentNode; //first parent in hierarchy must be a list item
        console.log(item);
        let tagSelected = item.parentNode.dataset.tagSelected;
        if(tagSelected){
            if(tagSelected === "true"){
                this.availableTagList.prepend(itemParent);
                itemParent.dataset.tagSelected = "false";
                item.textContent = '+';
                return;
            } 
            if (tagSelected === "false"){
                this.selectedTagList.prepend(itemParent);
                itemParent.dataset.tagSelected = "true";
                item.textContent = '-';
                return;
            }
        } 
    }
    
    attachHandlersToNew(item){
        item.addEventListener('click', () => {
            let taVal = this.$templateTextArea.val();
            let curPos = this.templateTextArea.selectionStart;
            this.$templateTextArea.val( taVal.slice( 0, curPos ) + this.asTag(item.dataset.tag) + taVal.slice( curPos ) );
        });
    }
    
    listGroupItem(tagName){
        return `
        <li class="list-group-item d-flex justify-content-between" data-tag="${tagName}" data-tag-selected="false">
            ${tagName}
            <div class="btn btn-primary" data-toggle="modal" data-target="#tagEditModal" data-tag-source=""><i class="fa fa-edit"></i></div>
            <div class="btn btn-primary" data-tag-action="selector">+</div>
        </li>
        `
    }

    asTag(tagName){
        return `<${tagName}></${tagName}>`
    }

    removeDuplicateSelected(){
        let selectedTagsDataArray = this.selectedTags.map(t => t.dataset.tag);
        console.log(selectedTagsDataArray);
        this.availableTags.forEach(item => {
            if(selectedTagsDataArray.includes(item.dataset.tag)){
                item.remove();
            }
        })
    }

    modalHandler(){
        $('#tagEditModal').on('show.bs.modal', function (event) {
            var button = $(event.relatedTarget) // Button that triggered the modal
            var tagSource = button.data('tagSource') // Extract info from data-* attributes
            console.log(tagSource);
            // If necessary, you could initiate an AJAX request here (and then do the updating in a callback).
            // Update the modal's content. We'll use jQuery here, but you could use a data binding library or other methods instead.
        })
    }

    handleNewTag(){
        let form = document.getElementById('testformid');
        form.addEventListener('ajax:success', (event) => {
            var detail = event.detail;
            var data = detail[0], status = detail[1], xhr = detail[2];
            if(data.status === "Created"){
                this.$availableTagList.prepend(this.listGroupItem(data.tag.display_name))
            }
            if(data.status === "Duplicate"){
                console.log("DUPLICATE");
            }
          })
    }
}