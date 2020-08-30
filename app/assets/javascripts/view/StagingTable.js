class StagingTable{

    /**
     * Class used to generate "staging" table where all prepared messages can be viewed before sending.
     * @param  {PreparedMessageContainer} content PreparedMessageContainer object that responds to getJson() method.
     */
    constructor(content){
        if (!content) throw new Error("Staging Table cannot be created without Prepared Messages");
        this._content = content.getJson().message_request.messages;
        this._headerRow = null;
 
        this.buildTableScaffold();
        this.addHtmlAttributes();
    }

    buildTableScaffold(){
        this._table = document.createElement('table'),
        this._thead = document.createElement('thead'),
        this._theadRow = document.createElement('tr'),
        this._tbody = document.createElement('tbody');
        this._table.appendChild(this._thead);
        this._thead.appendChild(this._theadRow);
        this._table.appendChild(this._tbody);
    }

    addHtmlAttributes(){
        this._table.classList.add('table', 'table-striped', 'table-bordered', 'table-hover-cells');
        this._table.setAttribute('id', 'stagingTable');
    }

    /**
     * Sorts prepared messaged based on given criteria and returns Map object with sorted content;
     * @param  {} option criteria to sort by, use {by: "subject"} or {by: "recipient"}
     */
    sort(option){
        let tableMap = new Map();
        if(option.by === "subject"){
            let uniqueSubjects = [...new Set(this._content.map(message => message.subject))];
            uniqueSubjects.forEach(subject => {
                tableMap.set(subject, this._content.filter(message => message.subject === subject));
            });
            return tableMap;
        }
        if(option.by === "recipient"){
            let uniqueRecipients = [...new Set(this._content.map(message => message.recipient))]
            uniqueRecipients.forEach(recipient => {
                tableMap.set(recipient, this._content.filter(message => message.recipient === recipient));
            });
            return tableMap;
        }
    }

    renderStagingAreaTable(tableMap){
        this.buildHeaderContent(tableMap);
                
        let maxRows = this.maxRows(tableMap);
        let mapLength = this.mapLength(tableMap);
        let mapValues = this.mapValues(tableMap);
        let tr = null;
        let innerIndex = 0;

        for (let index = 0; index < mapLength*maxRows; index++) {
            if (index % mapLength === 0) {
                tr = this._tbody.insertRow(); 
            }
            let cell = tr.insertCell();
            let message = this.getMessageFromMapValues(mapValues, index % mapLength, innerIndex);
            this.buildCellContentFromMessage(cell, message);
            if (index % mapLength === mapLength - 1){
                innerIndex++;
            } 
        }
        return this._table;
    }

    /** 
     * Return length of longest nested Array in Map.
     * @param  {} tableMap Map with Arrays as values
     */
    maxRows(tableMap){
        return [...tableMap.values()].reduce((max, cur) => {
            if(cur.length > max){
                max = cur.length;
            }
            return max;
        },0)
    }
  
    /** 
     * Returns number of keys stored on Map
     * @param  {} anyMap
     */
    mapLength(anyMap){
        return [...anyMap.keys()].length;
    }

    /**
     * Returns Array of values present in Map
     * @param  {} anyMap
     */
    mapValues(anyMap){
        return [...anyMap.values()];
    }

    isEmpty(){
        return this._content.length <= 0;
    }

    getMessageFromMapValues(map, arrNo, index){
        if(map[arrNo]){
            return map[arrNo][index] ?? null; 
        }
        return null;
    }

    buildHeaderContent(tableMap){
        tableMap.forEach((messages, subject) => {
            let headerCell = document.createElement('th');
            let headerCellText = document.createTextNode(subject);
            headerCell.appendChild(headerCellText);
            this._theadRow.appendChild(headerCell);
        });
    }

    buildCellContentFromMessage(cell, message){
        if(message){
            cell.appendChild(document.createTextNode(message.recipient));
            this.handleCellClick(cell, message);
            this.handleCellHover(cell, message);
            this.buildCellPopover(cell, message);
        }
    }

    handleCellClick(cell, message){
        cell.addEventListener('click', () => {
            console.log(message);
        });
    }

    handleCellHover(cell, message){
        cell.addEventListener('mouseover', (e) => {
            setTimeout(() => {
                $('.popover-body').html(message.content);
            }, 50);
        })
    }
    
    buildCellPopover(cell, message){
        cell.dataset.toggle = "popover";
        cell.dataset.trigger = "hover";
        cell.dataset.content = message.content;
        cell.classList.toggle("staging-popover");
    }
}