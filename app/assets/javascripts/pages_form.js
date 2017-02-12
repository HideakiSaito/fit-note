//<script type="text/javascript">
  var dispflag = 0;
  var disp_no = 1;
  var memo;
  var carbo;
  var fat;
  var protein;
  var vegetable;
  var last_meal = $("#last_meals");
  //食事メニューのエレメントを取得
  function get_food_element(p_no){
    memo = $("#page_diet_memo_" + p_no );
    carbo = $("#page_carbohydrate_" + p_no );
    fat = $("#page_fat_" + p_no );
    protein = $("#page_protein_" + p_no );
    vegetable = $("#page_vegetable_" + p_no );
    last_meal = $("#last_meals");
  }
  //文字列を数値で扱うように初期r
  function temp_reset(p_val){
    var temp = p_val; 
    if (temp.length > 0 ){ temp = Number(temp); }else{ temp = 0;}
    return temp;
  }
  //食事メニューと栄養素を追加する
  function food_add(p_no,p_name,p_carbohydrate,p_fat,p_protein,p_vegetable){
    var temp;
    //食事メニュの追加
    temp = memo.val(); if (temp.length > 0 ) { temp += "、"; }
    memo.val(temp + p_name); 
    //最後に食べた食事のIDを追加（クリアをとりあえず考慮しない）
    temp = last_meal.val(); if (temp.length > 0 ) { temp += ","; }
    last_meal.val(temp + p_no)
    //炭水化物の追加
    temp = temp_reset(carbo.val());
    carbo.val(temp + Number(p_carbohydrate) );
    //脂肪の追加
    temp = temp_reset(fat.val());
    fat.val(temp + Number(p_fat));
    //たんぱく質の追加
    temp = temp_reset(protein.val());
    protein.val(temp + Number(p_protein));
    //野菜の追加
    temp = temp_reset(vegetable.val());
    vegetable.val(temp + Number(p_vegetable));
    var mes = "選択したID" + p_no + " 食事NO" + disp_no + ":" + p_name;
    $.growl({ title: '追加しました', message: mes });
    $('#dialog').dialog('close');
  }
  //値のクリア
  function clear_food(p_no){
    get_food_element(p_no);
    memo.val("");
    carbo.val("");
    fat.val("");
    protein.val("");
    vegetable.val("");
  }
  //食事メニューを開く
  function select_food(p_no){
    get_food_element(p_no);
    disp_no = p_no;
    $('#dialog').dialog('open');
  }

function select_category(p_no){
  $("#food-table > *").hide();
  $(".category_" + p_no).show();
}
//食事メニューのダイアログ定義
$(function() {
  $( "#dialog" ).dialog({
    autoOpen: false,
    modal: true,
    width: 440,
    height: 580,
    buttons: {
      "1 定番": function(){
        select_category('1');
      },
      "2 肉、魚": function(){
        select_category('2');
      },
      "3 卵": function(){
        select_category('3');
      },
      "4 乳": function(){
        select_category('4');
      },
      "5 穀物": function(){
        select_category('5');
      },
      "6 豆、ナッツ": function(){
        select_category('6');
      },
      "7 野菜": function(){
        select_category('7');
      },
      "8 果物": function(){
        select_category('8');
      },
      "9 サプリ": function(){
        select_category('9');
      },
      "10 他": function(){
        select_category('10');
      },
      "OK": function(){
        $(this).dialog('close');
      }
    }
  });
  //ボタンにイベントをバインドする
  $( "#food1" ).click(function(){ select_food(1) });
  $( "#food2" ).click(function(){ select_food(2) });
  $( "#food3" ).click(function(){ select_food(3) });
  $( "#food4" ).click(function(){ select_food(4) });
  $( "#food5" ).click(function(){ select_food(5) });
  $( "#food1_cl" ).click(function(){ clear_food(1) });
  $( "#food2_cl" ).click(function(){ clear_food(2) });
  $( "#food3_cl" ).click(function(){ clear_food(3) });
  $( "#food4_cl" ).click(function(){ clear_food(4) });
  $( "#food5_cl" ).click(function(){ clear_food(5) });
});
//　</script>
