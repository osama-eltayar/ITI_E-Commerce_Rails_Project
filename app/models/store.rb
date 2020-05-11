class Store < ApplicationRecord
  belongs_to :user
  has_many :products
  validates :name, presence: true, uniqueness: { case_sensitive: false }

    delegate :can?, :cannot?, to: :ability
    def ability
      @ability ||= Ability.new(self)
    end

end
