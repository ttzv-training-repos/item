$('#stagingModal').on('shown.bs.modal', function() {
    if (messageContainer !== null){
        let stagingTable = new StagingTable(messageContainer);
        stagingTable.isEmpty() ? $('#send-request').attr('disabled', true) : $('#send-request').attr('disabled', false)
        let table = stagingTable.renderStagingAreaTable(
            stagingTable.sort(
                {by: "subject"}
                ));
        $('#staging-table-area').empty().append(table);
        $('.staging-popover').popover({
            html: true
        });
        handleSortingChange(stagingTable);
    }
})
$('#stagingModal').on('hide.bs.modal', function() {
    $('#staging-table-area').empty();
});

function handleSortingChange(stagingTable){
    let $tableSortingSwitch = $('#tableSortingSwitch');
    $tableSortingSwitch.change(() => {
        let checked = $tableSortingSwitch.prop('checked');
        if (checked){
            $('#staging-table-area').empty()
            .append(stagingTable.renderStagingAreaTable(
                stagingTable.sort(
                    {by: "recipient"}
                    )));
            $('.staging-popover').popover({
                html: true
            });
        } else {
            $('#staging-table-area').empty()
            .append(stagingTable.renderStagingAreaTable(
                stagingTable.sort(
                    {by: "subject"}
                    )));
            $('.staging-popover').popover({
                html: true
            });
        }
    })
}
