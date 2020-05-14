class ProductsController < ApplicationController
    respond_to :html, :js
    def index
        ability = Product.all
        @products = ProductQuery.new.call(ability, params).paginate(page: params[:page])
        respond_with( @products, :layout => !request.xhr? )

    end

    def show

        @product = Product.find(params[:id])
        respond_with( @product, :layout => !request.xhr? )
    end

    def new
      @stores = Store.all
    @product = Product.new
    @store = current_user.store()
    authorize! :create, @product
    end

    def edit
        @product = Product.find(params[:id])
        # authorize! :manage, @product


    end

    def create
        @product = Product.new(product_params)
        # @product.store = current_user.store()
        @product.save
        redirect_to products_path

    end

    def update
        @product = Product.find(params[:id])
          if @product.update(product_params)
              redirect_to @product
          else
              render 'edit'
          end
    end

    def destroy
        @product = Product.find(params[:id])
        @product.destroy
        redirect_to products_path
    end


    private

    def product_params
        params.require(:product).permit(:title, :description, :price, :in_stock_quantity, :image, :brand_id, :category_id, :store_id)
    end
end
