class MaskBuilder{

    constructor(){
        this.queryElements();
        this.prefillMaskValue();
        this.allInputHandler();
        this.updatePreviewRequestParams();
        this.newMaskGroupHandler();
        this.groupCount = this.getGroupCount();
    }

    queryElements(){
        this.$maskValue = $('#tag_custom_mask_value');
    }

    updateMaskValue(){
        this.sanitizeHash();
        this.$maskValue.text(JSON.stringify(this.maskHash, undefined, 4));
    }

    allInputHandler(){
        $("#accordion").change((e) => {
            this.setMaskHashParams(e.target);
            this.updateMaskValue();
        });
    }

    sanitizeHash(){
        this.maskHash.forEach(h => {
            Object.keys(h).forEach( k => {
                if (Object.keys(h[k]).length === 0){
                    delete h[k];
                }
            });
        });
    }

    setMaskHashParams(input){
        let inputValue = input.value;
        let action = input.dataset.maskAction;
        let param = input.dataset.maskParam;
        let group = this.groupFromId(input);
        if (action){
            if (this.maskHash[group][action] === undefined) this.maskHash[group][action] = {};
            if (this.cleared(input)){
                delete this.maskHash[group][action][param];  
            } else {
                this.maskHash[group][action][param] = inputValue;
            }
        } else if (param === "attribute"){
            this.maskHash[group][param] = inputValue;
        }
    }

    cleared(input){
        if (["radio", "checkbox"].includes(input.type)){
            return !input.checked;
        } else {
            return input.value.length === 0
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
            this.maskHash = [{
                attribute: '',
                insert: {},
                replace: {},
                remove: {},
                other: {}
            }];
        } else {
            this.parseMask();
        }
        this.updateMaskValue();
    }

    prefillInputValues(){
        let dataActionAttr = "data-mask-action";
        let dataParamAttr = "data-mask-param";
        for (let index = 0; index < this.maskHash.length; index++) {
            //todo
        }
    }

    newMaskGroupHandler(){
        $("#addMaskGroup").click(() => {
            let clone = this.cloneMaskGroup();
            clone.querySelectorAll("input").forEach( input => {
                input.value='';
            });
            $("#accordion").append(clone);
            this.groupCount += 1;
            this.maskHash.push({});
        });
    }

    cloneMaskGroup(){
        let clone = document.getElementById("maskGroup").cloneNode(true);
        clone.id = this.newId(clone.id, this.groupCount);
        clone.querySelectorAll("[id]").forEach(element => {
            let id = element.id;
            element.id = this.newId(id, this.groupCount);
        });
        clone.querySelector("[data-target]").dataset.target = this.newId("#collapse", this.groupCount);
        return clone;
    }

    getGroupCount(){
        let cards = [...document.getElementById("accordion").childNodes];
        return cards.filter( c => {
            return c.classList ? c.className.includes("card") : false
        }).length
    }

    newId(orig, iterator){
        return `${orig}_${iterator}`;
    }

    groupFromId(input){
        return input.id.includes("_") ? input.id.split("_")[1] : 0;
    }



}