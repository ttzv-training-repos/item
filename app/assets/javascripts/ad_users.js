var dataTable;
$(document).ready( function () {
    dataTable = $( "#ad_users" ).DataTable({
        select: true
    });
});

$('#users-select').click(handleSelection)
$('#users-clear').click(handleDeselection)

function handleSelection(params) {
    console.log(dataTable.rows({selected: true}).data());
}
function handleDeselection(params) {
    console.log(dataTable.rows({selected: true}).data());
}