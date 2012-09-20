class Users::RegistrationsController < Devise::RegistrationsController
  # POST /resource
  def create
    build_resource
    generate_twilio_number

    if resource.save
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)
        respond_with resource, :location => step_2_path
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => step_2_path
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end
  
  private
  def generate_twilio_number
    resource.twilio_number = "1234"
  end
end
