require 'clockwork'
require 'net/http'
module Clockwork

  def wake_up
    p "起きて" 
  end
  def one_minute
    p "minutely job"
  end

  def one_hour
    p "hourly job"
  end

  handler do |job|
#    self.send(job.to_sym)
   p 'ok '
  Net::HTTP.version_1_2
  body = Net::HTTP.start('http://hidepon3110d.herokuapp.com', 80) { |http|
   response = http.get('/about') # ディレクトリを指定
   response.body
  }
  p body
  end

  every(25.minute, :one)
#  every(1.minute, 'one_minute')
#  every(1.hour, 'one_hour')
end
