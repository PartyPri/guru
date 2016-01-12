$(document).ready(function() {
  //user page navigation
  $(".user-page-nav").attr("href", function(i, href) {
    return href;
  }).on('click', function() {
    var href = this.getAttribute('href');
    $('html, body').animate({scrollTop: $(href).offset().top - 115}, 'slow');
  });
});
