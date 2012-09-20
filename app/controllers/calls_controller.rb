class CallsController < ApplicationController

  # Twilio call params
  # GET adaptive-twilio.herokuapp.com/calls/07525374961?AccountSid=ACa449ea226485eaa8dba00e8584f7d591&ToZip=&FromState=&Called=%2B442033221069&FromCountry=GB&CallerCountry=GB&CalledZip=&Direction=inbound&FromCity=&CalledCountry=GB&CallerState=&CallSid=CAa08f083d6d8864e3c798e35058cb7e96&CalledState=London&From=%2B447717512838&CallerZip=&FromZip=&ApplicationSid=AP63324d0b74e3e4b6995291deebc9723d&CallStatus=ringing&ToCity=&ToState=London&To=%2B442033221069&ToCountry=GB&CallerCity=&ApiVersion=2010-04-01&Caller=%2B447717512838&CalledCity= dyno=web.1 queue=0 wait=0ms service=14ms status=200 bytes=208
  #
  # Twilio record params
  # Parameters: {"AccountSid"=>"ACa449ea226485eaa8dba00e8584f7d591", "ToZip"=>"", "FromState"=>"", "Called"=>"+442033221069", "FromCountry"=>"G
  # B", "CallerCountry"=>"GB", "CalledZip"=>"", "Direction"=>"inbound", "FromCity"=>"", "CalledCountry"=>"GB", "CallerState"=>"", "CallSid"=>"CA4570c67cda0f031afaff479810c2ff68", "CalledState"=>"London", "From"=>"+447545232300", "CallerZip"=>"", "FromZip"=>"", "ApplicationSid"=>"AP63324d0b74e3e4b6995291deebc9723d", "CallStatus"=>"completed", "ToCity"=>"", "ToState"=>"London", "RecordingUrl"=>"http://api.twilio.com/2010-04-01/Accounts/ACa449ea226485eaa8dba00e8584f7d591/Recordings/REb6d34cf37a22fc5919cd69b8773674e7", "To"=>"+442033221069", "Digits"=>"hangup", "ToCountry"=>"GB", "RecordingDuration"=>"4", "CallerCity"=>"", "ApiVersion"=>"2010-04-01", "Caller"=>"+447545232300", "CalledCity"=>"", "RecordingSid"=>"REb6d34cf37a22fc5919cd69b8773674e7"}

  def twilio_response
    sid = params['CallSid']
    user = User.find_by_twilio_number(params['Called'])
    caller_number = params['Caller']
    call_time = Time.now

    # Caller logic should be place below
    response = Twilio::TwiML::Response.new do |r|
      vm = "The person you're calling can't answer the phone. Leave a message and they'll get back to you."
      r.Say(vm, voice: 'woman')
      r.Record(timeout: 10, maxLength: 600, transcribe: true, action: 'http://adaptive-twilio.herokuapp.com/recordings')
      c = Call.create(sid: sid, caller_number: caller_number, call_time: call_time)
      c.user = user
      c.save
    end

    render :text => response.text
  end

  def twilio_record
    sid = params['RecordingSid']
    call = Call.find_by_sid(params['CallSid']) 
    url = "#{params['RecordingUrl']}.mp3"
    message = twilio_client.account.get(ENV['TWILIO_SID']).transcriptions.get(sid).transcription_text 
    duration = params['Duration']
    
    Recording.create(sid: sid, call: call, url: url, message: message, duration: duration) 
    render :text => "Hey there Twilio"
  end

end
