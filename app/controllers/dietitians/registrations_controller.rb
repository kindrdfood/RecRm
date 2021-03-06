# http://stackoverflow.com/questions/16379554/strong-parameters-with-rails-4-0-and-devise
class Dietitians::RegistrationsController < Devise::RegistrationsController

  before_filter :configure_permitted_parameters, except: [:edit]

  prepend_before_filter :require_no_authentication, only: [ :new, :create, :cancel ]
  prepend_before_filter :authenticate_scope!, only: [:edit, :update, :destroy]

  before_action :set_dietitian, only: [:show]


  def index
    @online_dietitians = Dietitians::DietitianPresenter.present(Dietitian.online)
    @dietitians = Dietitians::DietitianPresenter.present(Dietitian.all)
  end

  # GET /resource/sign_up
  def new
    build_resource({})
    @validatable = devise_mapping.validatable?
    if @validatable
      @minimum_password_length = resource_class.password_length.min
    end
    yield resource if block_given?
    respond_with self.resource
  end

  # POST /resource
  def create
    build_resource(sign_up_params)

    resource_saved = resource.save
    yield resource if block_given?
    if resource_saved
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      @validatable = devise_mapping.validatable?
      if @validatable
        @minimum_password_length = resource_class.password_length.min
      end
      respond_with resource
    end
  end

  # GET /resource/1
  def show
    if current_dietitian
      @user = current_dietitian 
    elsif current_user 
      @user = current_user 
    else
      @user = nil
    end
  end

  # GET /resource/edit
  def edit
    # build images
    
    if current_dietitian.main_avatar != false
      
      @main_avatar = current_dietitian.main_avatar
    else
      current_dietitian.images.build
    end

    # if expertises or reset expertises
    current_dietitian.expertises.count >= 1 ? current_dietitian.expertises : Expertise.reset_dietitian_expertise(current_dietitian)
    
    render :edit
  end

  # PUT /resource
  # We need to use a copy of the resource because we don't want to change
  # the current user in place.
  def update
    
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, bypass: true
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  # DELETE /resource
  def destroy
    resource.destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message :notice, :destroyed if is_flashing_format?
    yield resource if block_given?
    respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    expire_data_after_sign_in!
    redirect_to new_registration_path(resource_name)
  end

  protected

  def update_needs_confirmation?(resource, previous)
    resource.respond_to?(:pending_reconfirmation?) &&
      resource.pending_reconfirmation? &&
      previous != resource.unconfirmed_email
  end

  # By default we want to require a password checks on update.
  # You can overwrite this method in your own RegistrationsController.
  def update_resource(resource, params)

    if params[:images_attributes]
      params[:images_attributes]["0"].delete(:image_cache)
    end

    resource.update_with_password(params)
  end

  # Build a devise resource passing in the session. Useful to move
  # temporary session data to the newly created user.
  def build_resource(hash=nil)
    self.resource = resource_class.new_with_session(hash || {}, session)
  end

  # Signs in a user on sign up. You can overwrite this method in your own
  # RegistrationsController.
  def sign_up(resource_name, resource)
    sign_in(resource_name, resource)
  end

  # The path used after sign up. You need to overwrite this method
  # in your own RegistrationsController.
  def after_sign_up_path_for(resource)
    after_sign_in_path_for(resource)
  end

  # The path used after sign up for inactive accounts. You need to overwrite
  # this method in your own RegistrationsController.
  def after_inactive_sign_up_path_for(resource)
    scope = Devise::Mapping.find_scope!(resource)
    router_name = Devise.mappings[scope].router_name
    context = router_name ? send(router_name) : self
    context.respond_to?(:root_path) ? context.root_path : "/"
  end

  # The default url to be used after updating a resource. You need to overwrite
  # this method in your own RegistrationsController.
  def after_update_path_for(resource)
    
    # if images_attribuets and not remove_image
    # then send to crop image
    if params[:dietitian][:images_attributes].present? && !params[:dietitian][:images_attributes]["0"]["remove_image"].present?
      
        image = current_dietitian.images.last
        crop_dietitian_image_path(resource, image)
    else
      signed_in_root_path(resource)
    end
  end

  # Authenticates the current scope and gets the current resource from the session.
  def authenticate_scope!
    send(:"authenticate_#{resource_name}!", force: true)
    self.resource = send(:"current_#{resource_name}")
  end

  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up)
  end

  def account_update_params
    
    # if remove image attribute is present then destroy image
    
    if params 
      if params[:dietitian][:images_attributes]
        if params[:dietitian][:images_attributes]['0'][:remove_image] == "1"
          params[:dietitian].delete(:images_attributes)
          image = current_dietitian.images.last 
          image.remove_image!
          # image.update_attribute(:image, nil)
          image.remove_image = true
          image.save
          # image.reload
          image.destroy
          
        end
      end
    end
    
    # configure_permitted_parameters
    return devise_parameter_sanitizer.sanitize(:account_update)
  end



  protected

    # Use callbacks to share common setup or constraints between actions.
    def set_dietitian

        @dietitian = Dietitian.find(params[:id])
    end

    def configure_permitted_parameters
      
      devise_parameter_sanitizer.for(:sign_up) do |u| 
        u.permit(:first_name, :last_name, :email, :signature, :password, :password_confirmation, :current_password)
       end
      devise_parameter_sanitizer.for(:account_update) do |u|  

        u.permit(:first_name, :last_name, :email, :phone_number, :signature, :location, :password, :password_confirmation, :current_password, :remove_image, :undergraduate_education, :graduate_education, :professional_experience_first, :professional_experience_second, :professional_experience_third, :professional_experience_fourth, :professional_experience_fifth, :introduction, :experience_level, :age_level, :expertises_attributes => [:dietitian_preference, :dietitian_qualification, :dietitian_id, :patient_group_id, :id], :images_attributes => [:image_type, :imageable_id, :imageable_type, :position, :image_cache, :crop_x, :crop_y, :crop_w, :crop_h, :crop_image, :remove_image, :image])
       end
       
    end


end