require 'test_helper'

class StoreTest < ActiveSupport::TestCase
  test "Can't save without store name" do
    @store = Store.new
    # @store.name = "TestStore"
    @store.user_id = users(:one).id
    assert_not @store.save
  end

  test "Can't save without assigning user to the store" do
    @store = Store.new
    @store.name = "TestStore"
    # @store.user_id = users(:one).id
    assert_not @store.save
  end

  test "Store is saved successfuly" do
    @store = Store.new
    @store.name = "TestStore"
    @store.user_id = users(:one).id
    assert @store.save
  end
end
