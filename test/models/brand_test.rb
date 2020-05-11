require 'test_helper'

class BrandTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "brand should not save without title" do
    brand = Brand.new
    brand.name="a"
    assert brand.save
  end
end
