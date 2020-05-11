class Coupon < ApplicationRecord
    has_many :orders

    validates :name , presence: true ,  uniqueness: true
    validates :expiration_date , presence: true
    validates :usage_limit , presence: true
    validates :deduction_type , presence: true
    validates :deduction_amount , presence: true

end
