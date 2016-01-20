# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "ready page:load",->
  change_page_copy_at = ->
    if $("#page_copy").prop("checked")
      $("#copy_page_id").show()
    else
      $("#copy_page_id").hide()
  $("#page_copy").bind("click",change_page_copy_at)

  change_page_copy_at()


