ActiveAdmin.register Store do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :description, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :description, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
    # seller = User.find(params[:user_id])
    # seller

    before_action :assigned_to_user, only: :create
    controller do

      def create
        # Good
        @store = Store.new(permitted_params[:store])
        if @store.save
          @seller = User.find(params[:store][:user_id])
          @seller.seller!
          redirect_to admin_stores_path
        end
      end

      private

      def assigned_to_user
        @seller = User.find(params[:store][:user_id])
        if @seller.store
          flash[:error] = "Seller is already assigned to store"
          redirect_to new_admin_store_url # halts request cycle
        end
      end

    end



      form title: 'A custom title' do |f|
         inputs 'Details' do
           input :seller, input_html: { value: current_user.username,  disabled: true}
           input :name
           input :description
         end
         actions
       end


end
