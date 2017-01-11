$(document).ready(function () {
  $('#filter-read-button').on('click', filterRead)
  $('#filter-unread-button').on('click', filterUnread)
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

function filterUnread() {
  $('.link').each(function(index, link) {
    if ($(link).data('read')) {
      $(link).hide();
    } else {
      $(link).show();
    }
  });
}
