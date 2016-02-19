$(document).ready(function(){
  $('.notification-read').click(function(){
    var notificationId = '#notification-' + $(this).data('nid');
    $(notificationId).remove();

    var badgeCount = $('.notification-badge');
    var num = parseInt(badgeCount.html(), 10);
    badgeCount.html(num - 1);
  });
});
