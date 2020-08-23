$('#stagingModal').on('shown.bs.modal', function() {
    if (messageContainer !== null){
        let stagingTable = new StagingTable(messageContainer.getPreparedMessages());
        let table = stagingTable.render();
        $('#staging-table-area').empty().append(table);
    }
})
