module RepsCalculator
  #max
  def max_reps(weight,count)
  	### 入力ないのはリターン
  	if weight == nil  or count == nil 
      return 0
    end
   ### 重量の計算 
     #自重のサポート系（プルアップマシンとか）は引く。
     if weight <= 0.0 
       weight = 65.0 +  weight
     end
   ### 係数の計算
     coefficient = 0.25
     #1回はMAX
     coefficient = 1.0 if count == 1
     #2-5回は2.5％づつ下がる。 
     if count >1.0 and count <= 5.0
       temp = count - 1.0
       coefficient = 1.0 - (0.025 * temp)
     end
     #6回以上は90%から2%づつ下がる。
     if count > 5.0
       temp = count - 5.0
       coefficient = 0.9 - (0.02 * temp)
     end
     ### 変なあたいがあると０除算とかするので
     if coefficient < 0.25
      coefficient = 0.25
     end
     ###MAX挙上重量を計算する
     return (weight * (1.0 / coefficient )).round(2)
  end

  def line_max_reps(line)
    line_reps=[]
    line_reps <<  max_reps(line.weight_1,line.reps_1).to_f
    line_reps <<  max_reps(line.weight_2,line.reps_2).to_f 
    line_reps <<  max_reps(line.weight_3,line.reps_3).to_f 
    line_reps <<  max_reps(line.weight_4,line.reps_4).to_f 
    line_reps <<  max_reps(line.weight_5,line.reps_5).to_f 
    return line_reps.max
  end
end
