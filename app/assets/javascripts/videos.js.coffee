jQuery ->
	$('#reeldrag').sortable({
	items: "> li:not(.m-bottom-20#exclude)",
	placeholder: "sortable-placeholder"});