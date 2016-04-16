rails g scaffold mode name detail
rails g scaffold part name
rails g scaffold equipment name
rails g scaffold item name reps:integer part:belongs_to mode:belongs_to equipment:belongs_to
rails destroy scaffold item
rails destroy scaffold training

#2016/04/07
#食事管理機能のために
# diet model
# name    weight up ,weight down none
#
rails g scaffold diet name
#ok

#2016/04/16
rails g controller maintenance

#2016/04/07
#食事管理機能のために
#page add
#carbohydrate fat protein vegetable diet_memo
rails g migration AddColumnToPage diet:belongs_to carbohydrate_1:float fat_1:float protein_1:float vegetable_1:float diet_memo_1:string carbohydrate_2:float fat_2:float protein_2:float vegetable_2:float diet_memo_2:string carbohydrate_3:float fat_3:float protein_3:float vegetable_3:float diet_memo_3:string carbohydrate_4:float fat_4:float protein_4:float vegetable_4:float diet_memo_4:string carbohydrate_5:float fat_5:float protein_5:float vegetable_5:float diet_memo_5:string 

#2016/04/07
#休息管理
#page add 疲れ、気分、睡眠、水分,体重
#2016/04/16
#page add アルコール量（ビール）、カフェイン量（コーヒー） 、仕事、勉強、テレビ、インター年と量など
#　fatigue　feeling　sleep water
# faigue model : name score
# feeling model : name score
# sleep float
# water float
#  controler security
#  view => form _page

