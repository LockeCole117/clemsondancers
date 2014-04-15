function remove_fields(link) {
  $(link).prev("input[type=hidden]").value = "1";
  $(link).closest(".fields").remove();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  var container = document.getElementById("image_container");
  $(link).before(content.replace(regexp, new_id));
}