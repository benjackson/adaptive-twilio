class Call < ActiveRecord::Base
  attr_accessible :sid, :caller_number, :call_time

  belongs_to :user
  has_one :recording
end
