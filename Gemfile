source 'https://rubygems.org'

#ruby '2.2.3'
#ruby '2.2.1'
#ruby ' 2.2.6' #windows 対応  surface対応
ruby '~>2.2.6' #surface対応
#ruby '2.3.0' #2018/08rail
 
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.4'
### H.saito Del >>>>>>>>>>>>>>>>>>>>>>>>>>>>
# Use sqlite3 as the database for Active Record
##gem 'sqlite3'
### H.saito Del <<<<<<<<<<<<<<<<<<<<<<<<<<<<

gem 'serviceworker-rails'

### H.saito Add >>>>>>>>>>>>>>>>>>>>>>>>>>>>
# Use postgresql as the database for Active Record
#gem 'pg' #windows surface
gem 'pg','~> 0.20.0'
gem 'rails_12factor', group: :production
### H.saito Add <<<<<<<<<<<<<<<<<<<<<<<<<<<<
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
gem 'coffee-script-source', '1.8.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'bullet'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  #h.saito add 2016/06/02 RailsアプリでER図とかクラス図を作る
  gem "railroady" #bundle exec rake diagram:all
  gem "rails-erd" #bundle exec rake erd
  gem "ruby-graphviz"

gem 'ruby-debug-ide'  #2017/02/06 add VSCODEでデバッグ用
gem 'debase'          #2017/02/06 add VSCODEでデバッグ用
end

  #### Add H.Saito ######
  # for manage page 自前でやろう
##gem 'activeadmin', github: 'activeadmin'
gem 'inherited_resources' #これで書いたソースが動かないので入れる。上と一緒に入ってくるらしい。

gem 'bootstrap-sass', '~> 3.4.1'
gem 'font-awesome-sass'

 ## Add H.saito spaql###
gem "linkeddata"
gem "sparql"

## Add H.saito チャート###
gem 'lazy_high_charts'
## ページネーション
gem 'will_paginate'

## Add H.saito 2016/05/01 decolatea
gem 'draper'

## Add H.saito 2016/05/09 timer
#gem 'clockwork'
#
#facebook 連動
gem 'omniauth-facebook'

#windows 対応 2017/01/13
gem 'nokogiri', '~> 1.6', '>= 1.6.7.rc3'
gem 'bcrypt-ruby', '~> 3.1.0', require: 'bcrypt'
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
