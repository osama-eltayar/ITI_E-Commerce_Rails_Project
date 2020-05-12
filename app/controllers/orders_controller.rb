class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def index
    if current_user.buyer?
      @orders = Order.where(user_id: current_user.id)
    else
      redirect_to shopping_carts_path
    end
  end

  def show
    @order = Order.find(params[:id])
    authorize! :read, @order
  end 
  

  def new
    redirect_to shopping_carts_path
  end

  def edit
    redirect_to shopping_carts_path
  end

  def create

    @order = Order.new(user_id: current_user.id, status: "Pending")

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    redirect_to shopping_carts_path
  end

  def destroy
    
    @order.destroy
    @order = Order.find(params[:id])
    authorize! :destroy, @order
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
   
end
