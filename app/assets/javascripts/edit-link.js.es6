function attachEditEvents () {
  $('.link-title').on('focusout', editLink)
  $('.link-url').on('focusout', editLink)
}

function editLink () {
  console.log('win')
  var $linkDiv = $(this).closest('.link')

  var id = $linkDiv.data('id')

  var link = {
      title: $linkDiv.find('.link-title').text(),
      url: $linkDiv.find('.link-url').text()
    }

  $.ajax({
    url: `/api/v1/links/${id}`,
    method: 'put',
    type: 'json',
    data: link
  }).fail(displayEditFailure)
}

function displayEditFailure (failureData) {
  $("#links-list").prepend('<p>' + JSON.parse(failureData.responseText) + '</p>')
}
