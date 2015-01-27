require "cheepcreep/version"
require "cheepcreep/init_db"
require "httparty"
require "pry"

module Cheepcreep
  class GithubUser < ActiveRecord::Base
  end
end

class Github
  include HTTParty
  base_uri 'https://api.github.com'

  def initialize(user = 'apitestfun', pass = 'ironyard1')
    @auth = {:username => user, :password => pass}
  end

  #takes a username and returns a list of their followers usernames via the [followers call][followers]
  def get_followers(input = 'redline6561', options = {})
    options.merge!({:basic_auth => @auth})
    resp = self.class.get("/users/#{input}/followers", options)
    data = JSON.parse(resp.body)

    users_info = []

    data.each do |x|
      users_info << get_user_info(x['login'])
    end
    return users_info
  
  end

  #grabs a single username
  def get_user_info(input = 'redline6561', options = {})
    options.merge!({:basic_auth => @auth})
    resp = self.class.get("/users/#{input}", options)
    JSON.parse(resp.body)
  end
end


class CheepcreepApp < ActiveRecord::Base
  
end



def user_input_for_followers
  print "Enter a username to pull their followers: "
  gets.chomp
end

def get_username
  print "Enter a username to pull their info: "
  gets.chomp
end

def insert_database(users = [])
  users.each do |x|
    Cheepcreep::GithubUser.create(login: x['login'], name: x['name'], blog: x['blog'], plublic_repos: x['public_repos'], followers: x['followers'], following: x['following'])
  end
  puts "Database updated successfully."
  gets
end


user_name = 'apitestfun'
password = 'ironyard1'

exit = false


while exit != 2
  system 'clear'
  puts "Github API tests..."
  ghub_bot = Github.new

  puts "1) Get a user's followers"
  puts "2) Exit"
  exit = gets.chomp.to_i

  case exit
  when 1
    followers = user_input_for_followers
    data_followers = ghub_bot.get_followers(followers)
    insert_database(data_followers)
  end

end

