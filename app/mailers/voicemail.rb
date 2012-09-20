class Voicemail < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.voicemail.new_voicemail.subject
  #
  def new_voicemail_email(call)
    @user = call.user
    @call = call
    @recording = call.recording
    mail to: "to@example.org", subject: "New voicemail!"
  end
end
