class TwilioNumberController < ApplicationController
  
  before_filter :authenticate_user!
  
  def show
    @twilio_number = current_user.twilio_number
  end
end
