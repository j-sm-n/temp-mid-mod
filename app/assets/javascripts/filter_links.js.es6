$(document).ready(function () {
  $('#filter-read-button').on('click', filterRead)
})

function filterRead () {
  $('.link').each(function(index, link) {
    if (!$(link).data('read')) {
      $(link).hide()
    } else {
      $(link).show()
    }
  })
}
