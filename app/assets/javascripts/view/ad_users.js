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
    ItemAJAXRequest.sendCartRequest({
        cart_request: {
            action: "select",
            data: guids(selectedData)
        }
    }).done(function proceed(response){
        updateHolder(response.data);
    });
}
function handleDeselection(params) {
    ItemAJAXRequest.sendCartRequest({
        cart_request: {
            action: "clear",
            data: null
        }
    }).done(function proceed(response){
        updateHolder(response.data);
    });
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