class CouponsController < ApplicationController
  load_and_authorize_resource 

  
  def index
    @coupons = Coupon.all
  end


  def create
    @coupon = Coupon.new(coupon_params)
    if @coupon.save
       redirect_to @coupon
    else 
      render 'new'
    end
  end

  def new
    @coupon = Coupon.new
  end


  def edit
    @coupon = Coupon.find params[:id]

  end

  def update
    @coupon = Coupon.find params[:id]
    if @coupon.update coupon_params
      redirect_to @coupon
    else
      render 'edit'
    end
  end

  def show
    @coupon = Coupon.find params[:id]

  end

  def destroy
    @coupon = Coupon.find(params[:id])
    if @coupon.destroy
       redirect_to coupons_path
    end  
  end

  end



private
def coupon_params
  params.require(:coupon).permit(:name, :expiration_date, :usage_limit, :deduction_type, :deduction_amount)
end  
