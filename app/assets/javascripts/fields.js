function remove_fields(link) {
  $(link).prev("input[type=hidden]")[0].value = "1";
  $(link).closest(".fields").hide();
}

function add_fields(parent_element_query, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  var container = document.getElementById("image_container");
  $(parent_element_query).append(content.replace(regexp, new_id));
}