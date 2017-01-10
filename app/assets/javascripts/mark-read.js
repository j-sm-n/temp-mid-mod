function attachMarkAsReadEvent () {
  $('#links-list').on('click', 'button.mark-read', function () {
    var $this = $(this)
    var $linkId = $this.parents('.link').data('id')
    var $link = $this.parents('.link')

    $.post("https://hot-reads-jh.herokuapp.com/links", $link)

    $.ajax({
      url: '/api/v1/links/' + $linkId,
      method: 'PATCH',
      data: {read: true}
    }).fail(console.log('nope'))
  })
}
