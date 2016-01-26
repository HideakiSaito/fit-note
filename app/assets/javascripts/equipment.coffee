#page load
$ ->
  $('#equipments')
    .on 'click', '.edit, .cancel', (event) ->
      #表示切り替え
      toggleEditor $(this).closest('.equipment')

    .on 'ajax:complete', '.edit_equipment', (event,ajax,status) ->
      #ajax発火
      alert status + ajax.responseText
      #json解析
      response = $.parseJSON(ajax.responseText)
      name = response.data.name
      alert name
      #取得したデータを反映させる
      $container = $(this).closest('.equipment')
      $container.find('.viewr .body').text name
      #トグル切り替え
      toggleEditor $container

#切り替え関数
toggleEditor = ($container) ->
  $container.find('.viewr, .editor').toggle()

  $bodyField = $container.find('.editor .body')
  if $bodyField.is(':visible')
    $bodyField
      .val($container.find('.viewr .body').text())
      .select()

