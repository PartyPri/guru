$(document).ready(function(){
  $('.notification-read').click(function(){
    console.log("read clicked");
    var notificationId = '#notification-' + $(this).data('nid');
    console.log(notificationId);
    $(notificationId).remove();

    var badgeCount = $('.notification-badge');
    var num = parseInt(badgeCount.html(), 10);
    badgeCount.html(num - 1);
  });
});
