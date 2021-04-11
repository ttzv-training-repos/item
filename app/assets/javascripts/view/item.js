String.prototype.capitalize = function(){
    return this.charAt(0).toUpperCase + this.slice(1);
}

function format(d){
    function makeRow(item) {
        return `<tr style="cursor: pointer;" data-toggle="modal" data-target="#sentItemModal" data-itemId=${item.id}>
                    <td>${item.title}</td>
                    <td>${item.recipients}</td>
                    <td>${item.status}</td>
                    <td>${item.status_content}</td>
                </tr>`
    }

    return `
        <table class="table table-hover" id="itemsLogTable">
            <thead>
                <tr>
                    <th>Title</th>
                    <th>Recipient</th>
                    <th>Status</th>
                    <th>Status Message</th>
                </tr>
            </thead>
            <tbody>
                ${d.items.map(item => makeRow(item)).join('')}
            </tbody>
        </table>
    `
}

function formatFields(fields){
    function fieldName(field) {
        let name = field.split("-");
        return `${name[1]} ${name[2]}`;
    }
    return `<table>
                ${Object.keys(fields).map(key => {
                return `<tr>
                            <td>${fieldName(key)}</td>
                            <td>${fields[key]}</td>
                            <td>Copy</td>
                        </tr>`
                }).join('')}
            </table>`;
}

//add custom searching fuction to datatable
$.fn.dataTable.ext.search.push( 
    function (settings, searchdata, dataIndex, rowData, counter) {
        const searchValue = $('#detailSearch').val();
        const items = rowData.items;
        //should only work on table with this id
        if ( settings.nTable.id !== 'itemsLogTable' ) {
            return true;
        }
        if(Object.values(rowData).includes(searchValue)) return true;
        if(searchValue === '') return true;
        if(items.length === 0) return false;
        return items.some(item => {
            if (item.title.includes(searchValue)) return true;
            if (item.recipients.includes(searchValue)) return true;
            if (item.status.includes(searchValue)) return true;
            if (item.status_content.includes(searchValue)) return true;
        });
    }
    );

$(document).ready( function () {
    const itemsLogTable = $itemsLogDataTable = $( "#itemsLogTable" ).DataTable({
        "ajax": "item/sent_items",
        "columns": [
            {
                "className":      'details-control',
                "orderable":      false,
                "data":           null,
                "defaultContent": ''
            },
            { "data": "length" },
            { "data": "type" },
            { "data": "creator" },
            { "data": "date" }
        ]
    });

    $('#detailSearch').on('keyup', () => {
        itemsLogTable.draw();
    });

    $('#itemsLogTable_filter').hide();

    // Add event listener for opening and closing details
    $('#itemsLogTable tbody').on('click', 'td.details-control', function () {
        var tr = $(this).closest('tr');
        var row = itemsLogTable.row( tr );

        if ( row.child.isShown() ) {
            // This row is already open - close it
            row.child.hide();
            tr.removeClass('shown');
        }
        else {
            // Open this row
            row.child( format(row.data()) ).show();
            tr.addClass('shown');
        }    
    } );
    const $modalTitle = $('#sentItemModal .modal-title');
    const $modalBody = $('#sentItemModal .modal-body');
    const $modalContent = $('#modalContent');
    const $itemContent = $('#itemContent');
    const $itemRecipient = $('#itemRecipient');
    const $itemFields = $('#itemFields');
    const loadingCircle = `<div class="lds-ring"><div></div><div></div><div></div><div></div></div>`;
    //fetch item data and replace modal contents
    $('#sentItemModal').on('shown.bs.modal', function(e) {
        const id = e.relatedTarget.dataset.itemid;
        fetch(`item/sent_items/${id}`)
        .then(response => {
            if (response.ok){
                return response.json();
            }
            throw response;
        })
        .catch(error => alert(error))
        .then(json => {
            $modalContent.removeClass("d-none");
            console.log(json);
            $modalTitle.text(json.data.title);
            $itemContent.html(json.data.content);
            $itemRecipient.text(json.data.recipients);
            $itemFields.html(formatFields(JSON.parse(json.data.fields)));
        })
        .finally(() => {
            $(".lds-ring").remove();
        });
    });

    //
    $('#sentItemModal').on('hidden.bs.modal', function(e) {
        $modalContent.addClass("d-none");
        $modalTitle.empty();
        $modalBody.append(loadingCircle);
    });
});
