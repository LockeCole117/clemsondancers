//Looks for the closest hidden field (which is usually the 'remove' field) and sets it value
// to `true` (1), then hides the entire fieldset
function remove_fields(link) {
  $(link).prev("input[type=hidden]")[0].value = "1";
  $(link).closest(".fields").hide();
}

//generates a new instance of the fieldset based on the content provided,
//and appends it to the parent container DOM object (like an unordered list)
//the "id" of the fieldset is based on the current time, ensuring it's unique
function add_fields(parent_element_query, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  var container = document.getElementById("image_container");
  $(parent_element_query).append(content.replace(regexp, new_id));
}