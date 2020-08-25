var dataTable;
$(document).ready( function () {
    dataTable = $( "#ad_users" ).DataTable({
        select: true
    });
});

$('#users-select').click(handleSelection)
$('#users-clear').click(handleDeselection)

function handleSelection(params) {
    let selectedData = dataTable.rows({selected: true}).data();
    action = "select"
    data = {
        cart_request: {
            action: action,
            data: guids(selectedData)
        }
    };
    sendCartRequest(data);
}
function handleDeselection(params) {
    action = "clear"
    data = {
        cart_request: {
            action: action,
            data: null
        }
    };
    sendCartRequest(data);
}

function sendCartRequest(data){
    $.post("/item/user_holders", data,
        function (data, textStatus, jqXHR) {
        handleResponse(data);
        },
        "json"
    );
}

function guids(selectedData){
    const GUID_INDEX = 0;
    let guidsAry = [];
    selectedData.each(d => guidsAry.push(d[GUID_INDEX]))
    return guidsAry;
}

function handleResponse(response){
    console.log(response);
    User.all = response.data;
    User.current = response.data[0];
    updateHolder(response.data);
    templateViewBuilder.updateRecipientsDropdown();
}