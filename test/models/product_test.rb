require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "brand must be added to product" do
    product = products(:one)
    product.category=categories(:one)
    product.store=stores(:one)
    assert_not product.save
  end

  test "category must be added to product" do
    product = products(:one)
    product.brand=brands(:one)
    product.store=stores(:one)
    assert_not product.save
  end

  test "store must be added to product" do
    product = products(:one)
    product.category=categories(:one)
    product.brand=brands(:one)
    assert_not product.save
  end

  test "title must be added to product" do
    product = products(:two)
    product.category=categories(:one)
    product.brand=brands(:one)
    product.store=stores(:one)
    assert_not product.save
  end

  test "product added successfully" do
    product = products(:one)
    product.category=categories(:one)
    product.brand=brands(:one)
    product.store=stores(:one)
    assert product.save
  end

end
