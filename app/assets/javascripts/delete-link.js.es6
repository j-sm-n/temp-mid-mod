function attachDeleteEvent () {
  $('.delete-link').on('click', deleteLink)
}

function deleteLink () {
  var $this = $(this)
  var $linkId = $this.parents('.link').data('id')

  $.ajax({
    url: `/api/v1/links/${$linkId}`,
    method: 'delete',
    type: 'json'
  }).then(removeLink.bind(this))
}

function removeLink () {
  $(this).closest('.link').remove()
}
