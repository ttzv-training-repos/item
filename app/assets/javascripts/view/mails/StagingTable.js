class StagingTable{
    constructor(content){
        this._content = content
    }

    //Returns data needed for displaying table in staging area, after clicking send button.
    //By default template names are used in table headers. this behavior can be changed by providing option -  by: "mails" (not implemented)
    getStagingContent(options={}){
        let headers = new Array();
        let content = new Array();
        let row = 0;
        if (this._content.length > 0){
            this._content.forEach( message => {
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
                cell.appendChild(document.createTextNode(cellContent.user.ad_users_mail));
                cell.addEventListener('click', () => {
                    console.log(cellContent);
                    $('#staging-preview-area').empty().append(cellContent.content);
                })
            });
        });

        return table;
    }

    render(){
        let stagingContent = this.getStagingContent();
        return this.renderStagingAreaTable(stagingContent);
    }
}