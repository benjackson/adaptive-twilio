class CallsController < ApplicationController

  def show
    number = params[:number]

    # Caller logic should be place below
    response = Twilio::TwiML::Response.new do |r|
      r.Say("hello, this is the vociemail for #{number}, please leave a message", voice: 'woman')
      r.Record(timeout: 10, maxLength: 600, transcribe: true)
    end

    return response.text
  end

end
