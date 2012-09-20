class ApplicationController < ActionController::Base
  protect_from_forgery

  def twilio_client
    @twilio_client ||= Twilio::REST::Client.new(ENV['TWILIO_SID'], ENV['TWILIO_TOKEN'])
  end
  
end
