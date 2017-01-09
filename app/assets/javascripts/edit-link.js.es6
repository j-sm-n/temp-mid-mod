function attachEditEvents () {
  $('.link-title').on('focusout', editLink)
  $('.link-url').on('focusout', editLink)
}

function editLink () {
  var $linkDiv = $(this).closest('.link')

  var id = $linkDiv.data('id')

  var link = { link: {
      title: $linkDiv.find('.link-title').text(),
      body: $linkDiv.find('.link-url').text()
    }
  }

  $.ajax({
    url: `/api/v1/links/${id}`,
    method: 'put',
    type: 'json',
    data: link
  })
}
