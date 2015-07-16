jQuery ->
	$('#reeldrag').sortable({
	placeholder: "sortable-placeholder"});

	$('#sort_reel').click ->
		$.post($('#reeldrag').data('update-url'), $('#reeldrag').sortable('serialize'));
