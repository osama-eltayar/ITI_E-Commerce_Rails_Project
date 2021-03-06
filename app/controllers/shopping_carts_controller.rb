class ShoppingCartsController < ApplicationController
  respond_to :html, :js
  before_action :set_shopping_cart, only: [:show, :edit, :update, :destroy]

  # GET /shopping_carts
  # GET /shopping_carts.json
  def index
    @shopping_carts=ShoppingCart.carts(current_user)
  end

  # GET /shopping_carts/1
  # GET /shopping_carts/1.json
  def show
    redirect_to shopping_carts_path
  end

  # GET /shopping_carts/new
  def new
    redirect_to shopping_carts_path
  end

  # GET /shopping_carts/1/edit
  def edit
    redirect_to shopping_carts_path
  end

  def create
    products = ShoppingCart.cart_products(current_user)
    product = shopping_cart_params['product_id'].to_i

    if products.include?(product)
      @shopping_cart = ShoppingCart.where(order_id: nil, product_id: product, user_id: current_user.id).first
      @shopping_cart.quantity +=shopping_cart_params['quantity'].to_i
    else
      @shopping_cart = ShoppingCart.new(shopping_cart_params.merge(user_id: current_user.id, order_id: nil))
    end
    
    # abort @shopping_cart.inspect
    respond_to do |format|
      if @shopping_cart.save
        format.html { redirect_to shopping_carts_path, notice: 'successfull added.' }
        format.json { render  @shopping_cart, status: :created, location: @shopping_cart }
      else
        format.html { redirect_to root_path, alert: 'not available' }
        format.json { render json: @shopping_cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shopping_carts/1
  # PATCH/PUT /shopping_carts/1.json
  def update
    authorize! :update, @shopping_cart
    respond_to do |format|
      if @shopping_cart.update(shopping_cart_params_update)
        format.html { redirect_to shopping_carts_path, notice: 'Shopping cart was successfully updated.' }
        format.json { render :show, status: :ok, location: @shopping_cart }
      else
        format.html { redirect_to shopping_carts_path, alert: 'not available quantity' }
        format.json { render json: @shopping_cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shopping_carts/1
  # DELETE /shopping_carts/1.json
  def destroy
    @shopping_cart.destroy
    respond_to do |format|
      format.html { redirect_to shopping_carts_url, notice: 'Item was successfully deleted.' }
      format.js
      format.json { head :no_content }
    end
  end
  
  def confirm
    @shopping_cart = ShoppingCart.find(params[:id])
    authorize! :update, @shopping_cart
    ShoppingCart.find(params[:id]).update(status: "Confirmed")
    redirect_to shopping_carts_path 
  end

  def deliver
    @shopping_cart = ShoppingCart.find(params[:id])
    authorize! :update, @shopping_cart
    if (@shopping_cart.order.status == "Confirmed")
      @shopping_cart.update(status: "Delivered")
    end
    redirect_to shopping_carts_path 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shopping_cart
      @shopping_cart = ShoppingCart.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def shopping_cart_params 
      params.require(:shopping_cart).permit(:product_id, :quantity)
    end

    def shopping_cart_params_update   
      params.require(:shopping_cart).permit(:quantity)
    end
end
