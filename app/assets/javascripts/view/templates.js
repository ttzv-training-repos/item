if( $('body').attr('class') == 'templates edit'){
    let templateEditor = new TemplateEditor();
    templateEditor.build();
    console.log("template editor")
    hideOldTagPopovers();
    initializeTagPopovers();
}

function hideOldTagPopovers() {
    $('#tagSelectionArea').on('ajax:beforeSend', function (event) {
        console.log("before send")
        $('li[data-tag-name]').popover('hide');
    })
}

function initializeTagPopovers() {
    $('li[data-tag-name]').popover({
        trigger: 'hover',
        delay: { "show": 1000, "hide": 100 }
    });
}

