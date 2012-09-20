require 'spec_helper'

describe Users::RegistrationsController do
  context "POST create" do
    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      post :create, :user => { :name => "Ben", :password => "tester", :password_confirmation => "tester", :email => "test@example.com" }
    end
    
    it "should generate a twilio number" do
      User.first.twilio_number.should_not be_blank
    end
  end
end
