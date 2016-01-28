class SearchForm 
  include ActiveModel::Model
  # Formで使用するプロパティを定義する
  attr_accessor  :q

  # Validationを定義する
  # validates :bar, presence: true

end
