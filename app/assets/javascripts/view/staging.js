$('#stagingModal').on('shown.bs.modal', function() {
    if (messageContainer !== null){
        let stagingTable = new StagingTable(messageContainer);
        stagingTable.isEmpty() ? $('#send-request').attr('disabled', true) : $('#send-request').attr('disabled', false)
        let table = stagingTable.renderStagingAreaTable(
            stagingTable.sort(
                {by: "recipient"}
                ));
        $('#staging-table-area').empty().append(table);
        $('.staging-popover').popover({
            html: true
        });
    }
})
$('#stagingModal').on('hide.bs.modal', function() {
    $('#staging-table-area').empty();
});
