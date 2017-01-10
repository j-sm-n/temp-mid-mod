var $newLinkTitle, $newLinkUrl

$(document).ready(function () {
  $newLinkTitle = $("#link-title")
  $newLinkUrl = $("#link-url")

  $("#new-link").on('submit', createLink)
})

function createLink (event) {
  event.preventDefault()

  // console.log("win")

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
}

function linkHTML (link) {
    return `<div class='link' data-id='${link.id}' id="link-${link.id}">
              <p class='link-title' contenteditable="true">${ link.title }</p>
              <p class='link-url' contenteditable="true">${ link.url }</p>

              <p class="link_read">
                ${ link.read }
              </p>
              <p class="link_buttons">
                <button class="mark-read">Mark as Read</button><br>
                Read status: <div class='status'>${link.read}</div>
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
