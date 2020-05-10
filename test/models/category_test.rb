require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "category should not save without title" do
    category = Category.new
    category.name="aa"
    assert category.save
  end
end
