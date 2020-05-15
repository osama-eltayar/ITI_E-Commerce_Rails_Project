ActiveAdmin.register ShoppingCart do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :user_id, :product_id, :quantity, :price, :order_id, :status
  #
  # or
  #
  # permit_params do
  #   permitted = [:user_id, :product_id, :quantity, :price, :order_id, :status]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
      selectable_column
      id_column
      column :user
      column :product
      column :price
      column :quantity
      column :price
      column :order
      column :status
      actions
  end

end
