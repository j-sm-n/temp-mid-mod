var hotReads;
$(document).ready(function(){
  $.get('https://hot-reads-jh.herokuapp.com/reads', function(reads) {
    hotReads = reads;
  }).then(function() {
    $.get('/api/v1/links')
     .then(placeLinks)
  })
})

function placeLinks (links){
  links.forEach(renderLink);
}
