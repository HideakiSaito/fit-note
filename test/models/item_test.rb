require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "not nil" do
    item = Item.new 
    item.name = ""
    assert item.invalid?
    assert item.errors.include? :name  
    p item.errors
  end

  #TODO mataatode
  test "custom propaty1" do
    item = Item.first
    count = Item.count
  p item.name , item.part.name
    result = item.index_name
    assert_match   item.name ,result
    assert_match  item.part.name , result
  end

  #スコープテスト
  test "scope1" do
    items = Item.home
    items.each do |item|
      p item.name 
    end
  end
end 
