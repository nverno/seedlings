Shiny.addCustomMessageHandler(
    'collapse-search', 
    function(boxid) {
	var box = $('#' + boxid)
	if (box && box.css('display') != 'block') {
	    box.closest('.box').find('[data-widget=collapse]').click();
	}
    }
);
