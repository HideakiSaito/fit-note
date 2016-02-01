$ ->
#  $('#search').keyup ->
  $('#search').change ->
    #ajax send
    $.ajax
      url: 'parts/search'
      type: 'GET'
      data: word: $(this).val()

