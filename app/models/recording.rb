class Recording < ActiveRecord::Base
  attr_accessible :caller_number, :message, :url
end
