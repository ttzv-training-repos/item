class MaskBuilder{

    constructor(){
        this.queryElements();
        this.maskHash = {
            attribute: '',
            insert: {},
            replace: {},
            remove: {}
        }
        this.debugHandle();
        this.allInputHandler();
        this.inputValuesToMask();
        this.updateMaskValue();
    }

    queryElements(){
        this.$maskValue = $('#tag_custom_mask_value');
        this.$insertIndex = $('#insertIndex');
        this.$insertText = $('#insertIndex');
        // this.$insertAttr = $('#insertAttr');
        this.$replaceSearch = $('#replaceSearch');
        this.$replaceTo = $('#replaceTo');
        this.$removeIndex = $('#removeIndex');
        this.$previewArea = $('#previewArea');
        this.$getPreview = $('#getPreview');
        this.$debugRefresh = $('#debugRefreshMaskValue');
    }

    updateMaskValue(){
        this.$maskValue.text(JSON.stringify(this.maskHash, undefined, 4));
    }

    debugHandle(){
        this.$debugRefresh.click(() => {
            this.updateMaskValue();
        });
    }

    inputValuesToMask(){
        $('input, select').each((i, e) => {
            console.log(i, e)
            let inputValue = e.value;
            let action = e.dataset.maskAction;
            let param = e.dataset.maskParam;
            if (inputValue.length > 0){
                if (action){
                    this.maskHash[action][param] = inputValue;
                } else if (param) {
                    this.maskHash[param] = inputValue;
                }
            }
            console.log(action, param);
        });
        
    }

    allInputHandler(){
        $('input, select').change((e) => {
            let inputValue = e.target.value;
            let action = e.target.dataset.maskAction;
            let param = e.target.dataset.maskParam;
            if (inputValue.length > 0){
                if (action){
                    this.maskHash[action][param] = inputValue;
                } else {
                    this.maskHash[param] = inputValue;
                }
            }
            console.log(action, param);
        })
    }

}