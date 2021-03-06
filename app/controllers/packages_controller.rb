# == Schema Information
#
# Table name: packages
#
#  id                    :integer          not null, primary key
#  category              :string(255)
#  name                  :string(255)
#  full_price            :integer
#  description           :text
#  num_half_appointments :integer
#  num_full_appointments :integer
#  expiration_in_months  :integer
#  created_at            :datetime
#  updated_at            :datetime
#

class PackagesController < ApplicationController
  before_action :set_package, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_admin, only: [:new, :show, :new, :edit, :create, :destroy, :update]
  # GET /packages
  # GET /packages.json
  def index
    @packages = Package.all
    if current_user 
      @family = current_user.head_of_families.last
      @user_package = current_user.user_packages.last
      if @user_package

        @package = @user_package.package
        @half_sessions = @user_package.appointments.unused_package_session.where(duration: 30).length
        @full_sessions = @user_package.appointments.unused_package_session.where(duration: 60).length
      end
    end
  end

  # GET /packages/1
  # GET /packages/1.json
  def show
  end

  # GET /packages/new
  def new
    @packages = Package.all
    @package = Package.new
  end

  # GET /packages/1/edit
  def edit
  end

  # POST /packages
  # POST /packages.json
  def create

    @package = Package.new(package_params)

    respond_to do |format|
      if @package.save
        format.html { redirect_to @package, notice: 'Package was successfully created.' }
        format.json { render :show, status: :created, location: @package }
      else
        format.html { render :new }
        format.json { render json: @package.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /packages/1
  # PATCH/PUT /packages/1.json
  def update
    respond_to do |format|
      if @package.update(package_params)
        format.html { redirect_to @package, notice: 'Package was successfully updated.' }
        format.json { render :show, status: :ok, location: @package }
      else
        format.html { render :edit }
        format.json { render json: @package.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /packages/1
  # DELETE /packages/1.json
  def destroy
    @package.destroy
    respond_to do |format|
      format.html { redirect_to packages_url, notice: 'Package was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_package
      @package = Package.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def package_params
      params.require(:package).permit(:category, :name, :full_price, :description, :num_half_appointments, :num_full_appointments, :expiration_in_months)
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
