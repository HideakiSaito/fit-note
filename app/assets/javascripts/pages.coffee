$(document).on "ready page:load",->
  change_page_copy_at = ->
    if $("#page_is_copy").prop("checked")
      $("#copy_page_id").show()
    else
      $("#copy_page_id").hide()
  $("#page_is_copy").bind("click",change_page_copy_at)
  change_page_copy_at()

  change_page_hidden_lines_at = ->
    if $("#page_hidden_lines").prop("checked")
      $(".note").show()
    else
      $(".note").hide()
  $("#page_hidden_lines").bind("click",change_page_hidden_lines_at)
  change_page_hidden_lines_at()
  
  change_page_hidden_chart_at = ->
    if $("#page_hidden_chart").prop("checked")
      $(".chart").show()
    else
      $(".chart").hide()
  $("#page_hidden_chart").bind("click",change_page_hidden_chart_at)
  change_page_hidden_chart_at()

