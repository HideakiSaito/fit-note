$(document).on "ready page:load",->
  change_page_copy_at = ->
    if $("#page_is_copy").prop("checked")
      $("#copy_page_id").show()
    else
      $("#copy_page_id").hide()
  $("#page_is_copy").bind("click",change_page_copy_at)

  change_page_copy_at()


