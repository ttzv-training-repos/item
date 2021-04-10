
function format(d){
    function makeRow(item) {
        return `<tr style="cursor: pointer;" data-toggle="modal" data-target="#sentItemModal" data-itemId=${item.id}>
                    <td>${item.title}</td>
                    <td>${item.status}</td>
                    <td>${item.status_content}</td>
                </tr>`
    }

    return `
        <table class="table table-hover" id="itemsLogTable">
            <thead>
                <tr>
                    <th>Title</th>
                    <td>Status</td>
                    <td>Status Message</td>
                </tr>
            </thead>
            <tbody>
                ${d.items.map(item => makeRow(item)).join('')}
            </tbody>
        </table>
    `
}

$.fn.dataTable.ext.search.push( 
    function (settings, searchdata, dataIndex, rowData, counter) {
        const searchValue = $('#detailSearch').val();
        const items = rowData.items;
        console.log(searchValue, items);
        if ( settings.nTable.id !== 'itemsLogTable' ) {
            return true;
        }
        if(searchValue === '') return true;
        if(items.length === 0) return false;
        return items.some(item => {
            if (item.title.includes(searchValue)) return true;
            if (item.status.includes(searchValue)) return true;
            if (item.status_content.includes(searchValue)) return true;
        });
    }
 );

$(document).ready( function () {
    console.log("start drawing table");
    const table = $dataTable = $( "#itemsLogTable" ).DataTable({
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
            { "data": "date" }
        ]
    });

    $('#detailSearch').on('keyup', () => {
        table.draw();
    });

    // Add event listener for opening and closing details
    $('#itemsLogTable tbody').on('click', 'td.details-control', function () {
        var tr = $(this).closest('tr');
        var row = table.row( tr );
        console.log(row.data());

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

    $('#sentItemModal').on('shown.bs.modal', function(e) {
        const $modalTitle = $('#sentItemModal .modal-title');
        const $modalBody = $('#sentItemModal .modal-body');
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
            console.log(json);
            $modalTitle.text(json.data.title);
            $modalBody.html(json.data.content);
        })
        .finally(() => {
            console.log("Stop loading");
        });
    })
});


