class MaskBuilder{

    constructor(){
        this.queryElements();
        this.prefillMaskValue();
        this.allInputHandler();
        this.updatePreviewRequestParams();
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
        this.sanitizeHash();
        this.$maskValue.text(JSON.stringify(this.maskHash, undefined, 4));
    }

    debugHandle(){
        this.$debugRefresh.click(() => {
            this.updateMaskValue();
        });
    }

    inputValuesToMask(){
        $('input, select').each((i, e) => {
            this.setMaskHashParams(e);
        });
        
    }

    allInputHandler(){
        $('input, select').change((e) => {
            this.setMaskHashParams(e.target);
            this.updateMaskValue();
        });
    }

    sanitizeHash(){
        Object.keys(this.maskHash).forEach( k => {
            if (Object.keys(this.maskHash[k]).length === 0){
                delete this.maskHash[k];
            }
        });
    }

    setMaskHashParams(input){
        let inputValue = input.value;
        let action = input.dataset.maskAction;
        let param = input.dataset.maskParam;
        if (action){
            if (this.maskHash[action] === undefined) this.maskHash[action] = {};
            if (inputValue.length === 0){
                delete this.maskHash[action][param];     
            } else {
                this.maskHash[action][param] = inputValue;
            }
        } else if (param === "attribute"){
            this.maskHash[param] = inputValue;
        }
    }

    updatePreviewRequestParams(){
        let remoteLink = $("#getPreview")[0];
        remoteLink.addEventListener("ajax:before", function () {
            remoteLink.dataset.params = `ad_users_id=${User.current.ad_users_id}`;
        })
    }

    parseMask(){
        this.maskHash = JSON.parse(this.$maskValue.text());
        this.prefillInputValues();
    }

    prefillMaskValue(){
        if (this.$maskValue.text().length === 0){
            this.maskHash = {
                attribute: '',
                insert: {},
                replace: {},
                remove: {}
            }
        } else {
            this.parseMask();
        }
        this.updateMaskValue();
    }

    prefillInputValues(){
        if (this.$maskValue.text().length !== 0){
            $('input').each((i, e) => {
                let action = e.dataset.maskAction;
                let param = e.dataset.maskParam;
                if (action !== undefined && param !== undefined){
                    if(this.maskHash[action]) e.value = this.maskHash[action][param]
                }
            });
        }
    }

}