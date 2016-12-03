#postgers start
pg_ctl -D /usr/local/var/postgres start

rails g scaffold mode name detail
rails g scaffold part name
rails g scaffold equipment name
rails g scaffold item name reps:integer part:belongs_to mode:belongs_to equipment:belongs_to
rails destroy scaffold item
rails destroy scaffold training

#2016/04/07 ok
#食事管理機能のために
# diet model
# name    weight up ,weight down none
#
rails g scaffold diet name
#ok

#2016/04/16 ok
rails g controller maintenance

#2016/04/07 ok
#食事管理機能のために
#page add
#carbohydrate fat protein vegetable diet_memo
rails g migration AddColumnToPage diet:belongs_to carbohydrate_1:float fat_1:float protein_1:float vegetable_1:float diet_memo_1:string carbohydrate_2:float fat_2:float protein_2:float vegetable_2:float diet_memo_2:string carbohydrate_3:float fat_3:float protein_3:float vegetable_3:float diet_memo_3:string carbohydrate_4:float fat_4:float protein_4:float vegetable_4:float diet_memo_4:string carbohydrate_5:float fat_5:float protein_5:float vegetable_5:float diet_memo_5:string

rails g migration DelColumn1ToPage

#2016/04/07 ok
#休息管理
#page add 疲れ、気分、睡眠、水分,体重
#2016/04/16
#page add アルコール量（ビール）、カフェイン量（コーヒー） 、仕事、勉強、テレビ、インター年と量など
#　fatigue　feeling　sleep water
# condition model : name score
# feeling model : name score
# sleep float
# water float
#  controler security
#  view => form _page
rails g scaffold condition name score:float memo
rails g scaffold feeling name score:float memo
rails g migration AddColumnToPage2 condition:belongs_to feeling:belongs_to sleep_hour:float sleep_time:time water:float alcohol:float caffeine:float wight:float work_hour:float study_hour:float tv_hour:float

,:condition ,:feeling ,:sleep_hour ,:sleep_time ,:water ,:alcohol ,:caffeine ,:wight ,:work_hour ,:study_hour ,:tv_hour
#2016/04/17 ok
#ストレッチ。トレーニングの一貫として入れる。、有酸素、ストレッチの分類があれば

#2016/04/23
#training_hour
rails g migration AddCoulumn3ToPage training_hour:float
rake db:migrate
heroku run rake db:migrate

#2016/04/26
#food model
rails g scaffold food name diet:belongs_to calorie:float carbohydrate:float fat:float protein:float vegetable:float diet_memo:string

rails g migration AddCoulumn4ToPage body_fat_per:float body_size_neck:flaat  body_size_bust:float body_size_waist:float body_size_hip:float body_size_arm_right:float body_size_arm_left:float body_size_leg_right:float body_size_leg_left:float body_size_calf_right:float body_size_calf_left:float


,:body_fat_per,:body_size_neck,:body_size_bust,:body_size_waist,:body_size_hip,:body_size_arm_right,:body_size_arm_left,:body_size_leg_right,:body_size_leg_left,:body_size_calf_right,:body_size_calf_left


rails g scaffold food_category name no:integer order:integer

rails g migration AddColumn1ToFood food_category:belongs_to
rails g migration AddColumn2ToFood sort_key

#2016/05/09
#page_image model
rails g scaffold  page_image page:belongs_to data:binary content_type


#2016/05/19
rails g model user provider uid name email icon oauth_token oauth_expires_at:datetime
rails g scaffold user provider uid name email icon oauth_token oauth_expires_at:datetime
rake db:migrate

heroku config:set FACEBOOK_KEY=0123456789

#2016/04/2
#training_hour
rails g migration AddCoulumn1ToUser hashed_password
rake db:migrate
heroku run rake db:migrate

#2016/07/03
#user relation
rails g migration AddColumn_user_ToPage user:belongs_to
rake db:migrate
heroku run rake db:migrate

#2016/07/10
#training_hour
rails g migration AddCoulumn2ToUser administrator:boolean
bundle exec rake db:migrate
heroku run bundle exec rake db:migrate

bundle exec rake erd orientation=horizontal title='FitNote model diagram' inheritance=true notation=uml filetype=jpg

#2016/08/24
#many to many vote
rails g model item_vote user:belongs_to item:belongs_to
rails g model food_vote user:belongs_to food:belongs_to
bundle exec rake db:migrate
heroku run bundle exec rake db:migrate

#2016/09/17 #####################################VVVVV
# HideakiSaito/r1#9
# tipモデルを作る。ダイエット３１か条とか、トガシさんのアドバイスとかをランダムに出す
####
#tips model ehime ryokou densya de
rails g scaffold tip_category name:string
rails g scaffold tip_recommendation name:string rate:integer
rails g scaffold tip tip_category:belongs_to tip_recommendation:belongs_to name:string description:string author:string
bundle exec rake db:migrate
heroku run bundle exec rake db:migrate

##基本機能を作る
# ✅tip select-input
# ✅trash files
# ✅管理者権限機能
# ✅わかるアイコン

##admin name space へ移す。
# ✅ topにメニュー追加。
# ✅ class の名前を名前空間つき。
# ✅ とりあえず動くまで

# controller names
# ✅tip_categories
# ✅tip_recommendations
# ✅tips

## design #### ほぼ日手帳とか、フランクリンプランナー的なデザインで。
# ✅home page -> recommend area に。
# ✅page page -> 上の方か、growlで。
# ✅pages page -> 上の方か、growlで。

 ### labo tip/show で実験する

#ヒント
tip
 name #タイトル string
 description #説明 string
 author #ヒントくれた人
 tip_category_id #ヒントのカテゴリ many to one model
 tip_recommendation_id #おすすめモデル many to on model

#ヒント推奨レベル
tip_recommendation
 name #名前 string
 rate #星１〜５ integer

# data
# 絶対オススメ	5	,かなりオススメ	4	,まあまあオススメ	3	,できれば	2	,どっちでもいい	1

#ヒントカテゴリ
tip_category
 name #名前 string トレーニング関連:1、食事関連:2、休息:3、ダイエット全般:4、プログラム関連:5

# data
# トレーニング  ,ダイエット（食事）,休息, ダイエット（全般）,プログラム・IT

##英語のふくしtips_まさしさん
_at  場所、人
_on 時間（その時）
_by 手段、〜までに（時間）
_of 〜の
_for 〜のために
_to 〜に

############################################AAA
#2016/09/19 #####################################VVVVV
# HideakiSaito/r1#20
# プロフィール機能の追加（TOPに
# user model へ属性の追加
#  >
#  >
####
#tips model ehime ryokou densya de
rails g scaffold tip_category name:string
rails g scaffold tip_recommendation name:string rate:integer
rails g scaffold tip tip_category:belongs_to tip_recommendation:belongs_to name:string description:string author:string
bundle exec rake db:migrate
heroku run bundle exec rake db:migrate

##基本機能を作る
# ✅tip select-input
# ✅trash files
# ✅管理者権限機能
#

インポートごにすることseqの訂正
 select setval('foods_id_seq', (select max(id)+1 from foods) );
 select setval('items_id_seq', (select max(id)+1 from items) );

 #アプリ名称、リポジトリ名称を見直して、キーたとか色々見直し
 #
 
pbpasteを使う
Macには、pbpasteというclipboardの中身を出力するコマンドがある。
これと、:r !commandがcommandの出力を挿入することを組み合わせると…？
:r !pbpaste

#2016/11/15
#page_selfy model
rails g scaffold  page_selfy page:belongs_to data:binary content_type
bundle exec rake db:migrate
heroku run bundle exec rake db:migrate

#2016/11/23
sql="select date,sum(wight) as weight from pages group by date"
sql = "select to_char(date,'YY/MM/W') as ymw ,avg(wight) as weight,avg(body_fat_per) as fat from pages where true and wight > 0 group by to_char(date,'YY/MM/W') order by to_char(date,'YY/MM/W')"
w = Page.find_by_sql(sql).map(&:attributes)
w.each { |x| p x["weight"]  }


sql = "select to_char(date,'YY/MM/W') as date, 
avg( COALESCE(protein_1,0) + COALESCE(protein_2,0) + COALESCE(protein_3,0) + COALESCE(protein_4,0) + COALESCE(protein_5,0) ) as protein,
avg( COALESCE(fat_1,0) + COALESCE(fat_2,0) + COALESCE(fat_3,0) + COALESCE(fat_4,0) + COALESCE(fat_5,0) ) as fat,
avg( COALESCE(carbohydrate_1,0) + COALESCE(carbohydrate_2,0) + COALESCE(carbohydrate_3,0) + COALESCE(carbohydrate_4,0) + COALESCE(carbohydrate_5,0) ) as carbohydrate,
avg( COALESCE(vegetable_1,0) + COALESCE(vegetable_2,0) + COALESCE(vegetable_3,0) + COALESCE(vegetable_4,0) + COALESCE(vegetable_5,0) ) as vegetable 
from pages where true and wight > 0 group by to_char(date,'YY/MM/W') order by to_char(date,'YY/MM/W')"
select
COALESCE(vegetable_1,0) + COALESCE(vegetable_2,0) + COALESCE(vegetable_3,0) + COALESCE(vegetable_4,0) + COALESCE(vegetable_5,0) as vege ,
  date from pages where date > '2016/08/10';

sql = "select to_char(date,'YY/MM/W') as date, 
avg(sleep_hour) as sleep_hour,
avg(work_hour) as work_hour,
avg(study_hour) as study_hour,
avg(tv_hour) as tv_hour,
avg(training_hour) as training_hour
from pages where true and wight > 0 group by to_char(date,'YY/MM/W') order by to_char(date,'YY/MM/W')"

    t.float    "sleep_hour"
    t.float    "work_hour"
    t.float    "study_hour"
    t.float    "tv_hour"
    t.float    "training_hour"

      sql = "select to_char(date,'YY/MM/W') as date, 
             avg(sleep_hour) as sleep_hour,
             avg(work_hour) as work_hour,
             avg(study_hour) as study_hour,
             avg(tv_hour) as tv_hour,
             avg(training_hour) as training_hour
             from pages 
             where true and wight > 0 #{where}
             group by to_char(date,'YY/MM/W') 
             order by to_char(date,'YY/MM/W')"


iOSアプリ開発をしているとコンパイル回数が多いせいか、結構Macが重くなります。
不要なログ的なデータ削除だったり、メモリやCPUの開放だったりで軽くなることが多々有ります。

メモリ解放
sudo purge

メモリ解放（そこそこ時間かかります）
du -sx /

アプリとOSのキャッシュのアップデート
sudo update_dyld_shared_cache -force 

ドライバキャッシュのクリア
sudo kextcache -system-caches

カーネルエクステンションというドライバのキャッシュをクリアします。
カーネルキャッシュの更新
sudo kextcache -system-prelinked-kernel

メンテナンススクリプトの手動実行
sudo periodic daily weekly monthly

ls -l /var/log/*.out
sudo rm -rf ~/Library/Developer/Xcode/DerivedData
sudo rm -rf ~/Library/Developer/Xcode/Archives
sudo rm -rf ~/Library/Caches
