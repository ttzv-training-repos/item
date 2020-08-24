$('#stagingModal').on('shown.bs.modal', function() {
    if (messageContainer !== null){
        let stagingTable = new StagingTable(messageContainer.getPreparedMessages());
        stagingTable.empty() ? $('#send-request').attr('disabled', true) : $('#send-request').attr('disabled', false)
        let table = stagingTable.render();
        $('#staging-table-area').empty().append(table);
    }
})
