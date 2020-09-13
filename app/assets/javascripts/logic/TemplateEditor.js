class TemplateEditor{

    constructor(){

    }

    build(){
        this.selectElements();
        this.handleListsAction();
        this.removeDuplicateSelected();
    }

    selectElements(){
        this.selectedTagList = document.getElementById('selectedTags');
        this.availableTagList = document.getElementById('availableTags');
        this.selectedTags = [...this.selectedTagList.children];
        this.availableTags = [...this.availableTagList.children];
        this.$templateTextArea = $('#template_content');
        this.templateTextArea = document.getElementById('template_content');
    }

    handleListsAction(){
        this.selectedTagList.addEventListener('click', (e) => {
            let item = e.target
            let tagName = item.dataset.tag
            if(tagName){
                this.handleTagInsert(tagName)
            }
            this.handleTagSelection(item);
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
        return `<li class="list-group-item">${tagName}</li>`
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
}