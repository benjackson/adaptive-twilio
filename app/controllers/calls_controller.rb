class CallsController < ApplicationController

  # GET adaptive-twilio.herokuapp.com/calls/07525374961?AccountSid=ACa449ea226485eaa8dba00e8584f7d591&ToZip=&FromState=&Called=%2B442033221069&FromCountry=GB&CallerCountry=GB&CalledZip=&Direction=inbound&FromCity=&CalledCountry=GB&CallerState=&CallSid=CAa08f083d6d8864e3c798e35058cb7e96&CalledState=London&From=%2B447717512838&CallerZip=&FromZip=&ApplicationSid=AP63324d0b74e3e4b6995291deebc9723d&CallStatus=ringing&ToCity=&ToState=London&To=%2B442033221069&ToCountry=GB&CallerCity=&ApiVersion=2010-04-01&Caller=%2B447717512838&CalledCity= dyno=web.1 queue=0 wait=0ms service=14ms status=200 bytes=208

  def twilio_response
    called_number = params['Called']
    caller_number = params['Caller']
    call_sid = params['CallSid']
    call_time = Time.now

    # Caller logic should be place below
    response = Twilio::TwiML::Response.new do |r|
      r.Say("hello, this is the vociemail for #{called_number}, please leave a message", voice: 'woman')
      r.Record(timeout: 10, maxLength: 600, transcribe: true, action: '/record')
    end

    render :text => response.text
  end

  def twilio_record
    print "LOOK AT ME : #{params['RecordingUrl']}"
    render :text => "hello"
  end

end
