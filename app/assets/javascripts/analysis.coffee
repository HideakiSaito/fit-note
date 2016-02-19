$(document).on "ready page:load",->
  $('button').button()

  ##家トレーニング推移の制御
  home_btn = $('#home-toggle') #$はjQueryのエイリアス
  home_btn.button()
  chart_home_toggle = ->
    $('#chart_in_home').toggle('blind','',700)
  home_btn.bind("click",chart_home_toggle)
  chart_home_toggle() #最初は閉じておく。

  ##場所別トレーニング量の制御
  place_btn = $('#place-toggle') #$はjQueryのエイリアス
  place_btn.button()
  chart_place_toggle = ->
    $('#chart_pie_place').toggle('blind','',700)
  place_btn.bind("click",chart_place_toggle)
  chart_place_toggle() #最初は閉じておく。


