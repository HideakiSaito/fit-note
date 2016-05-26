require 'clockwork'
require 'net/http'
module Clockwork
  handler do |job|
    p Time.now 
    Net::HTTP.version_1_2
    body = Net::HTTP.start('http://hidepon3110d.herokuapp.com', 80) { |http|
      response = http.get('/about') # ディレクトリを指定
      response.body
    }
    p body
  end
  every(20.minute, :wake_up, if: lambda { |t| t.hour >= 7 and t.hour <= 22 }) 
end
