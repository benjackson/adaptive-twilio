class Recording < ActiveRecord::Base
  attr_accessible :sid, :message, :url, :duration

  belongs_to :call

  after_create :send_email

  def send_email
    Voicemail.new_voicemail_email(self)
  end
end
