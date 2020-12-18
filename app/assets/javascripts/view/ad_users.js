var $dataTable = null;
$(document).ready( function () {
    console.log("start drawing table")
    $dataTable = $( "#ad_users" ).DataTable({
        select: true,
        "scrollX": true,
        "scrollY":        "60vh",
        "scrollCollapse": true,
        "paging":         false
    });
});

$( "#ad_users" ).on('draw.dt', function () {
    console.log( 'Redraw occurred at: '+new Date().getTime() );
    $( "#usersTableArea" ).removeClass("opaque");
    $("#usersTablePrg").remove();
} );

$('#users-select').click(handleSelection)
$('#users-clear').click(handleDeselection)

function handleSelection(params) {
    let selectedData = $dataTable.rows({selected: true}).data();
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

function guids(selectedData){
    const GUID_INDEX = 0;
    let guidsAry = [];
    selectedData.each(d => guidsAry.push(d[GUID_INDEX]))
    return guidsAry;
}

function handleResponse(response){
    if (response){
        console.log(response);
        User.all = response.data;
        User.current = response.data[0];
        updateHolder(response.data);
    }
}