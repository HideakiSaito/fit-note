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
