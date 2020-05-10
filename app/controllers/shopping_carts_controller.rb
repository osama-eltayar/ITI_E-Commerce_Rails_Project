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
    @shopping_cart = ShoppingCart.new
    authorize! :create, @shopping_cart
  end

  # GET /shopping_carts/1/edit
  def edit
  end

  def create
    authorize! :create, @shopping_cart
    @shopping_cart = ShoppingCart.new(shopping_cart_params.merge(user_id: current_user.id, order_id: nil))

    respond_to do |format|
      if @shopping_cart.save
        format.html { redirect_to @shopping_cart, notice: 'Shopping cart was successfully created.' }
        format.json { render  @shopping_cart, status: :created, location: @shopping_cart }
      else
        format.html { render :new }
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
        format.html { redirect_to @shopping_cart, notice: 'Shopping cart was successfully updated.' }
        format.json { render :show, status: :ok, location: @shopping_cart }
      else
        format.html { render :edit }
        format.json { render json: @shopping_cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shopping_carts/1
  # DELETE /shopping_carts/1.json
  def destroy
    @shopping_cart.destroy
    respond_to do |format|
      format.html { redirect_to shopping_carts_url, notice: 'Shopping cart was successfully destroyed.' }
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
      
      params.permit(:product_id, :quantity)
    end

    def shopping_cart_params_update   
      params.require(:shopping_cart).permit(:quantity)
    end
end
