class Recording < ActiveRecord::Base
  attr_accessible :sid, :message, :url, :duration, :call

  belongs_to :call

  after_create :send_email

  def send_email
    Voicemail.new_voicemail_email(call)
  end
end
