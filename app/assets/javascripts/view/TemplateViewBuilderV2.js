class TemplateViewBuilderV2{
    constructor(){
        this._recipients = new Array();
    }

    queryTemplateViewElements(){
        this.$senderInput = $('#sender');
        this.$buttonDropdownMenu = $('#buttonDropdownMenu');
        this.$buttonAddRecipient = $('#buttonAddRecipient');
        this.$inputEmailAddress = $('#inputEmailAddress');
        this.$vInputs = $('#vInputs')
        this.$title = $('#title');
        this.$content = $('$content')
    }

    handleSenderChange(){
        this.$senderInput = $('#sender');
    }
}