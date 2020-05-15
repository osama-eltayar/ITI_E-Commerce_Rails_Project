class ShoppingCart < ApplicationRecord
  belongs_to :user
  belongs_to :product
  belongs_to :order, optional: true

  validate :check_available
  validates_associated :product
  validates :quantity, :numericality => { :greater_than_or_equal_to => 1 }

  def self.carts(user)
    if(user.buyer?)
      ShoppingCart.where(order_id: nil, user_id: user.id)
    elsif(user.seller?)
      ShoppingCart.where.not(order_id: nil).where(product_id: user.products)
    elsif(user.admin?)
      ShoppingCart.all
    end
  end

  def self.cart_products(user)
    ShoppingCart.where(order_id: nil, user_id: user.id).select(:product_id).map(&:product_id)
  end

  def self.submit_current_cart(user, order)
    carts = self.carts(user)    
    carts.update_all(order_id: order, status: "Pending")
    carts
  end

  def pinned?
    self.status == "Pending"
  end

  def order_confirmed?
    self.order.status == "Confirmed"
  end

  def confirmed?
    self.status == "Confirmed"
  end

  def avilable_product
    product.in_stock_quantity
  end

  def user_name
    user.username
  end

  before_save :calculate_price 
  after_update :check_status
  # after_save :change_available_quantity_in_product 
  # before_destroy :release_holding_quantity

  def release_holding_quantity
    product.change_available_quantity -(self.quantity)
  end
  
  private
    def calculate_price
      self.price = product.price * self.quantity
    end

    def check_status
      if order.present?
        order.update_status(self.status)
      end
    end

   

    def available_quantity? 
      old_quantity = quantity_was || 0
      available = product.in_stock_quantity
      quantity <= (available + old_quantity)
    end

    def check_available
      unless available_quantity?
        errors.add(:quantity, "sorry quantity no available ")
      end  
    end


    def change_available_quantity_in_product
      new_number = self.quantity
      old_number = self.quantity_before_last_save
      unless old_number.nil?
        new_number -= old_number
      end
      product.change_available_quantity new_number
    end
end
