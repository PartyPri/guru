function navColor(nav) {
    var property = document.getElementById(nav);
    property.className = 'toggled' == property.className ? '' : 'toggled';
}