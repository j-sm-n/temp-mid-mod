$(document).ready(function () {
  addLinks()
})

function addLinks () {
  $.getJSON('/api/v1/links')
  .then(function (allLinks) {
    allLinks.forEach(renderLink)
  })
  // .then(attachDeleteEvent)
  // .then(attachEditEvent)
  .fail(displayFailureAllLinks)
}

function displayFailureAllLinks () {
  $("#links-list").append('<p>Uh oh! Cannot find your links. Something went wrong.</p>')
}
