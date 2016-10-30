require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
   test "validation of name presence and uniqueness" do
   	 category = Category.new
   	 assert_not category.save, "Category can't be saved without name"
   	 category.name = 'Name'
     assert category.save, "Categoty should be saved with name set"
     category2 = Category.new
     category2.name = 'Name'
     assert_not category2.save, "Category shouldn't be saved when the name was already used for other category"
   end
   test "presence of price_and_fix_time_map static method" do
   	assert Category.price_and_fix_time_map, 'price_and_fix_time_map should be set'
   	assert_instance_of Hash, Category.price_and_fix_time_map, 'price_and_fix_time_map should return a hash'
   end
end
