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

  $("#notification-btn").click(function(){
    var notificationItems = $('.notification-item').map(function() {
      return $(this).attr('id');
    }).get();
    var notificationId = notificationItems.map(function(item){
      return item.split("-")[1];
    });
    notificationId.forEach(function(id) {
      $.ajax({
        type: 'PUT',
        url: '/notifications/' +id+ '?read=true',
        success: function(response) {
          console.log('notification-item-'+id+' : is marked as read');
        }
      })
    });
  });
});
