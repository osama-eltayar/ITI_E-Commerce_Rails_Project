class Product < ApplicationRecord
    belongs_to :brand
    belongs_to :category
    has_one_attached :image
    belongs_to :store
    # validate :image_type
    validates :brand_id, presence: true
    validates :category_id, presence: true
    validates :store_id, presence: true
    validates :title, presence: true, uniqueness: {
      case_sensitive: false,
      scope: [:store, :brand_id, :category_id],
      message: "should be unique in store, brand and category. this title already exists"
    }

    def change_available_quantity(number)
        # abort number.inspect
        self.in_stock_quantity = self.in_stock_quantity - number
        # abort self.inspect
        self.save
    end

    private
    def image_type
       if image.attached?
         if !image.content_type.in?(%('image/jpeg image/png image/jpg'))
           errors.add(:image, "needs to be a jpeg, jpg, png only!")
         end
       end
     end

end
