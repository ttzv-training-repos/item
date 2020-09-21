if( $('body').attr('class') == 'templates edit'){
    let templateEditor = new TemplateEditor();
    templateEditor.build();
    console.log("template editor")
    $('li[data-tag-name]').popover({
        trigger: 'hover'
    });
}

