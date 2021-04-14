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

function initFieldsSidebar(){
    const $width = $(window).width();
    const $sidebar = $('.sidebarFields');
    const $toggleBtn = $('#toggleFieldsSidebar');
    const shouldBeOpen = localStorage.getItem("fieldsSidebarActive");
    if($width <= 992 && shouldBeOpen === "true"){
        $sidebar.toggleClass('show');
        $toggleBtn.html('<i class="fas fa-chevron-right"></i>')
    }
    $toggleBtn.on('click', () => {
        if($width <= 992){
            $sidebar.toggleClass('show');
            const visible = $('.sidebarFields').hasClass('show')
            localStorage.setItem("fieldsSidebarActive", visible);
            visible ?
             $toggleBtn.html('<i class="fas fa-chevron-right"></i>') :
              $toggleBtn.html('<i class="fas fa-chevron-left"></i>');
        }
    });
}

 initFieldsSidebar();

