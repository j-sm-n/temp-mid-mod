var $newLinkTitle, $newLinkUrl

$(document).ready(function () {
  $newLinkTitle = $("#link-title")
  $newLinkUrl = $("#link-url")

  $("#new-link").on('submit', createLink)
})

function createLink (event) {
  event.preventDefault()

  var link = getLinkData()

  $.post("/api/v1/links", link)
   .then(renderLink)
   .then(clearLink)
   .fail(displayFailure)
 }

function getLinkData () {
 return {
   title: $newLinkTitle.val(),
   url: $newLinkUrl.val()
 }
}

function renderLink (link) {
  $("#links-list").prepend(linkHTML(link))
  if (link.read) {
    $("#link-" + link.id).addClass('read')
  }
  setStatus(link)
}

function linkHTML (link) {
  var mark_as = "Read"
  if (link.read) {
    mark_as = "Unread"
  }
    return `<div class='link' data-read=${link.read} data-id='${link.id}' id="link-${link.id}">
              <div class='status'></div>
              <p class='link-title' contenteditable="true">${ link.title }</p>
              <p class='link-url' contenteditable="true">${ link.url }</p>

              <p class="link_read">
                Read: ${ link.read }
              </p>
              <p class="link_buttons">
                <button class="mark-${mark_as}">Mark as ${mark_as}</button><br>
              </p>
            </div>`
}

function clearLink () {
  $newLinkTitle.val('')
  $newLinkUrl.val('')
}

function displayFailure (failureData) {
  $("#failure-data").append('<p>' + JSON.parse(failureData.responseText) + '</p>')
}

function setStatus (link) {
  var status = ""
  if (isTopResult(link)) {
    status = "Top!"
  } else if (isHotResult(link)) {
    status = "Hot!"
  }

  $('#link-' + link.id + ' .status').text(status)
}

function isTopResult(link) {
  return (hotReads[0].url == link.url)
}

function isHotResult(link) {
  return hotReads.some(function(read) {
    return read.url == link.url
  })
}
