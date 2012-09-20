class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :phone_number, :password, :password_confirmation, :marketing_opt_in, :remember_me
  # attr_accessible :title, :body
  
  validates :name, :presence => true

  has_many :calls
  
end
