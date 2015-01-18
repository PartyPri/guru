var addEventListeners, getName;

getName = function(button, print) {
  return $(button).change(function() {
    var name;
    name = $(this).val().replace(/^.*[\\\/]/, '');
    return $(print).text(name);
  });
};

addEventListeners = function() {
  return $('.upload').each(function() {
    var button, print;
    button = $(this);
    print = $(this).data("print");
    return getName(button, print);
  });
};

$(function() {
  return addEventListeners();
});
