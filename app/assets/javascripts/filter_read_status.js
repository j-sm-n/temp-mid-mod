$(document).ready(function () {
  $('#filter-read-button').on('click', function () {
    $links = $('.link')
    $links.each(function (index, link) {
      var $link = $(this).closest('.link').find('.status').text()
      if($link === 'true'){
        $(this).closest('.link').show()
      } else {
        $(this).closest('.link').hide()
      }
    })
  })
})
