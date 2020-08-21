class PreparedMessageContainer{

    constructor(sender){
        this.preparedMessages = new Array();
        this.sender = sender;
        this.requestHash = this.updateRequestJson();
    }

    addMessage(mail){
        if(!this.includes(mail)){
            this.preparedMessages.push(mail);
        }
    }

    addMessages(mails){
        mails.forEach(element => {
            this.addMessage(element);
        });
    }

    removeMessage(message){
        this.preparedMessages = this.preparedMessages.filter( msg => !msg.equals(message));
        this.updateRequestJson();
    }

    setSender(sender){
        this.requestHash.sender = sender;
    }

    getJson(){
        this.updateRequestJson();
        return {message_request: this.requestHash};
    }

    getMessage(template, user){
        let mail = new Mail(template, user)
        return this.preparedMessages.filter( msg => msg.equals(mail))[0]; //should ever be only one unless something goes horribly wrong
    }

    updateRequestJson(){
        this.requestHash = {
            sender: this.sender,
            messages: this.getMessageHashArray()
        }
    }

    includes(object){
        return this.indexOf(object) !== -1;
    }

    indexOf(object){
        if (!object instanceof Mail){
            throw TypeError('Can only compare Message objects')
        }

        let index = -1;

        for (let index = 0; index < this.preparedMessages.length; index++) {
            const msg = this.preparedMessages[index];
            if(object.equals(msg)) return index;
        }
        return index;
    }

    getMessageHashArray(){
        return this.preparedMessages.map(msg => msg.getJson());
    }

    updateMessagesContent(){
        this.preparedMessages.forEach(m => m.updateTemplateContent())
    }

    //Returns data needed for displaying table in staging area, after clicking send button.
    //By default template names are used in table headers. this behavior can be changed by providing option -  by: "mails" (not implemented)
    getStagingContent(options={}){
        let headers = new Array();
        let content = new Array();
        let row = 0;
        if (this.preparedMessages.length > 0){
            this.preparedMessages.forEach( message => {
                let title = message.template.title
                if (!headers.includes(title)){
                    headers.push(title)    
                } 
                row %= User.all.length;
                if (!content[row]) content.push([])
                content[row].push(message)
                row++;
            });
            return {headers: headers, content: content}
        } else {
            throw "Cant create staging content, no Messages and/or Users present"
        }
    }

    renderStagingAreaTable(stagingContent){
        if (stagingContent.headers === null) throw "Headers are required to build a table"
        if (stagingContent.content === null) throw "Content is null, can't build an empty table"

        let table = document.createElement('table'),
            thead = document.createElement('thead'),
            theadRow = document.createElement('tr'),
            tbody = document.createElement('tbody');
            
        table.classList.add('table', 'table-striped', 'table-bordered', 'table-hover-cells');
        table.setAttribute('id', 'stagingTable')
            
        table.appendChild(thead);
        table.appendChild(tbody);

        stagingContent.headers.forEach( header => {
            let headerCell = document.createElement('th');
            let headerCellText = document.createTextNode(header);
            headerCell.appendChild(headerCellText);
            theadRow.appendChild(headerCell);
        });
        thead.appendChild(theadRow);
                
        stagingContent.content.forEach( rowContent => {
            let tr = tbody.insertRow();
            rowContent.forEach(cellContent => {
                let cell = tr.insertCell();
                cell.appendChild(document.createTextNode(cellContent.user.mail));
                cell.addEventListener('click', () => {
                    console.log(cellContent);
                    $('#staging-preview-area').empty().append(cellContent.template.content);
                })
            });
        });

        return table;
    }

}