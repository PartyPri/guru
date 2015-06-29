jQuery ->
	$('#reeldrag').sortable({
	items: "> li:not(#exclude)",
	placeholder: "sortable-placeholder"});