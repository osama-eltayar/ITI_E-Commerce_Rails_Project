class ProductQuery
  def call(ability, params)
    ability=ability.where('title LIKE :search OR description LIKE :search', search: "%#{params[:search]}%")
    ability=ability.where('price >= :min',min: params[:min]) if params[:min].present?;
    ability=ability.where('price <= :max',max: params[:max]) if params[:max].present?;
    # byebug
    ability=ability.where(brand_id: params[:brand_id]) if params[:brand_id].present?;
    ability=ability.where(category_id: params[:category_id]) if params[:category_id].present?;
    ability=ability.where(store_id: params[:store_id]) if params[:store_id].present?;
    return ability
  end
end
