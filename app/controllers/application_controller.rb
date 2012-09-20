class ApplicationController < ActionController::Base
  protect_from_forgery

  def twilio_client
    @client = @client || Twilio::REST::Client.new(ENV['TWILIO_SID'], ENV['TWILIO_TOKEN'])
    return @client
  end
  
end
