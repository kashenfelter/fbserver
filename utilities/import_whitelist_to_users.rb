require File.join(File.dirname(__FILE__), '..', 'config', 'environment.rb')
require File.join(File.dirname(__FILE__), '..', 'app', 'workers', 'workers.rb')
require 'twitter'
require 'csv'
require 'resque'
require 'resque/plugins/lock'

class ProcessUserFriends
  extend Resque::Plugins::Lock
  @queue = :fetchfriends
  def self.perform(authdata)
  end
end

user_counter = 0 
users = User.where("twitter_token IS NOT NULL")

whitelist = CSV.read(ARGV[0])

whitelist.each do |row|
  screen_name = row[0]

  user_counter = 0 if(user_counter >= users.size)
  user = users[user_counter]
  user_counter += 1
  
  authdata = {:consumer_key => ENV["TWITTER_CONSUMER_KEY"],
              :consumer_secret => ENV["TWITTER_CONSUMER_SECRET"],
              :oauth_token => user.twitter_token,
              :oauth_token_secret => user.twitter_secret,
              :api_user => user.screen_name,
              :followbias_user => screen_name}
  puts authdata
  Resque.enqueue(ProcessUserFriends, authdata)
end