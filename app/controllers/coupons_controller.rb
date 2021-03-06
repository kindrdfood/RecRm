# == Schema Information
#
# Table name: coupons
#
#  id                :integer          not null, primary key
#  code              :string(255)
#  description       :string(255)
#  valid_from        :datetime
#  valid_until       :datetime
#  redemption_limit  :integer          default(1)
#  redemptions_count :integer          default(0)
#  amount            :integer
#  amount_type       :string(255)
#  status            :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#

class CouponsController < ApplicationController
  before_action :set_coupon, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_admin, only: [:index, :new, :show, :edit, :create, :update, :destroy]

  # GET /coupons
  # GET /coupons.json
  def index
    @coupons = Coupon.all
  end

  # GET /coupons/1
  # GET /coupons/1.json
  def show
  end

  # GET /coupons/new
  def new
    @coupon = Coupon.new
  end

  # GET /coupons/1/edit
  def edit
  end

  # POST /coupons
  # POST /coupons.json
  def create
    @coupon = Coupon.new(coupon_params)

    respond_to do |format|
      if @coupon.save
        format.html { redirect_to @coupon, notice: 'Coupon was successfully created.' }
        format.json { render :show, status: :created, location: @coupon }
      else
        format.html { render :new }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coupons/1
  # PATCH/PUT /coupons/1.json
  def update
    respond_to do |format|
      if @coupon.update(coupon_params)
        format.html { redirect_to @coupon, notice: 'Coupon was successfully updated.' }
        format.json { render :show, status: :ok, location: @coupon }
      else
        format.html { render :edit }
        format.json { render json: @coupon.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /coupon/redeem_coupon
  def redeem_coupon
    
    coupon_code = params[:coupon_code]
    
    # If coupon is redeemable
    if Coupon.redeem_coupon(coupon_code, current_user)

      # Get appointment in registration
      purchase = current_user.appointment_in_registration.purchase

      # Set new prices and coupon description
      @invoice_price = purchase.show_invoice_price
      @invoice_cost = purchase.show_invoice_cost
      
      @coupon_description = purchase.coupon_redemption.coupon.description

      flash.clear
      flash.now[:notice] = 'Coupon applied!'

    else

      # alert user coupon is not valid
      flash.clear
      flash.now[:alert] = 'Invalid coupon'
    end

    respond_to do |format|
      format.js
    end
  end

 # GET /coupon/remove_coupon
  def remove_coupon
    appointment = current_user.appointment_in_registration
    appointment.purchase.remove_coupon
    @invoice_price = appointment.purchase.show_invoice_price

    # alert user coupon has been removed
    flash.clear
    flash.now[:alert] = 'Coupon removed'

    respond_to do |format|
      format.js
    end
  end

  # DELETE /coupons/1
  # DELETE /coupons/1.json
  def destroy
    @coupon.destroy
    respond_to do |format|
      format.html { redirect_to coupons_url, notice: 'Coupon was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private


    # Use callbacks to share common setup or constraints between actions.
    def set_coupon

      #coupons/redeem was calling the set_coupon method even though it is not included in the only[]
        @coupon = Coupon.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def coupon_params
      params.require(:coupon).permit(:code, :description, :valid_from, :valid_until, :redemption_limit, :redemptions_count, :redemption_limit_per_user, :amount, :amount_type, :status)
    end

    # Only admin users can access coupon controller
    # should handle with pundit/rolify  correctly
    def authenticate_admin

      if current_dietitian && (current_dietitian.has_role? "Admin Dietitian")
         
      else
        redirect_to welcome_home_path
      end
    end
end
