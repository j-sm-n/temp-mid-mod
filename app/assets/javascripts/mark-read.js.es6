// function attachMarkAsReadEvent () {
//   $('#links-list').on('click', 'button.mark-read', function () {
//     var $this = $(this)
//     var $linkId = $this.parents('.link').data('id')
//     var $link = $this.parents('.link')
//
//     $.post("https://hot-reads-jh.herokuapp.com/links", $link)
//
//     $.ajax({
//       url: '/api/v1/links/' + $linkId,
//       method: 'PATCH',
//       data: {read: true}
//     }).fail(console.log('nope'))
//   })
// }

$(document).ready(function () {
  $('#links-list').on('click', 'button.mark-Read', setMarkRead)
  $('#links-list').on('click', 'button.mark-Unread', setMarkUnread)
})


function setMarkRead () {
  var $this = $(this)
  var link = $this.parents('.link')
  var linkId = link.data('id')
  sendToHotlinks.bind(this)()
  
  $.ajax({
    url: '/api/v1/links/' + linkId,
    method: 'PATCH',
    data: {read: true}
  })
   .then(function () {
    link.find('.link_read').text('Read: true')
    link.addClass('read')
    link.data('read', true)

    $this.text('Mark as Unread')
    $this.off()
  }).then(function () {
    $this.on('click', setMarkUnread)
  })
}
