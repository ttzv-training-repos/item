$('#stagingModal').on('shown.bs.modal', function() {
    console.log(messageContainer);
    if (messageContainer !== null){
        messageContainer.updateMessagesContent();
        let stagingContent = messageContainer.getStagingContent();
        let table = messageContainer.renderStagingAreaTable(stagingContent);
        $('#staging-table-area').empty().append(table);
    }
})
