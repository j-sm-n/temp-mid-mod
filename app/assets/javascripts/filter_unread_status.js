$(document).ready(function () {
  $('#filter-unread-button').on('click', function () {
    $links = $('.link')
    $links.each(function (index, link) {
      var $link = $(this).closest('.link').find('.status').text()
      if($link === 'false'){
        $(this).closest('.link').show()
      } else {
        $(this).closest('.link').hide()
      }
    })
  });
})
