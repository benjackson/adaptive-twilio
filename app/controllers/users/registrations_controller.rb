class Users::RegistrationsController < Devise::RegistrationsController
  # POST /resource
  def create
    build_resource
    
    if resource.valid?
      # Spend $1...
      generate_twilio_number
      resource.save
      
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)
        respond_with resource, :location => dashboard_path
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, :location => dashboard_path
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end
  
  private
  def generate_twilio_number
    numbers = twilio_client.available_phone_numbers.get('GB').local.list
    chosen_number = numbers.last.phone_number
    twilio_client.account.incoming_phone_numbers.create(:phone_number => chosen_number)
    resource.twilio_number = chosen_number
  end
end
