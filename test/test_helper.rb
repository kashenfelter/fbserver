ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'omniauth-twitter'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

#  def setup
#    if User.find_by_screen_name("FollowBias System").nil?
#      user = User.create({:screen_name=>"FollowBias System", :uid=> "-1"})
#      user.treatment="system"
#      user.save!
#    end
#  end

  # Add more helper methods to be used by all tests here...
  def setup_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      :provider => 'twitter',
      :uid => '101'
  })
  end
end
