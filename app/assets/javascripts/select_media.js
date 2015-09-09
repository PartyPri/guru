$(document).ready(function() {
  getSelectValue();

  $('#media-select').change(function() {
    getSelectValue();
  });
});

function getSelectValue() {
  reel_id = $('#media-select').val();

  $('.video-link').each(function() {
    this.href = "/videos/new?reel="+reel_id
  });

  $('.story-link').each(function() {
    this.href = "/stories/new?reel="+reel_id
  });
}