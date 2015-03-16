require 'kinja'
require 'dotenv'
Dotenv.load

class Updater
  POSTS = [
    "http://gemtest.kinja.com/gawker-1687581385"
  ]

  def self.client
    Kinja::Client.new(
      user: ENV["KINJA_USER"],
      password: ENV["KINJA_PASS"]
    )

  end

  def self.run
    POSTS.each do |post|
      client.update_post(post, publishTimeMillis: DateTime.now.strftime('%Q').to_i)
    end
  end

  def self.time_to_update(now, update_time)
    true
  end
end
