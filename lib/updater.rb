require 'kinja'
require 'dotenv'
Dotenv.load

class Updater
  POSTS = [
    {
      url: "http://gawker.com/dont-forget-you-can-email-us-tips-at-tips-gawker-com-1605185791",
      blog_id: 7
    }
  ]

  def self.client
    Kinja::Client.new(
      user: ENV["KINJA_USER"],
      password: ENV["KINJA_PASS"]
    )

  end

  def self.run
    timestamp = (DateTime.now - 365).strftime('%Q').to_i
    POSTS.each do |post|
      # post = client.get_post(post)
      # require 'pry'; binding.pry
      post = client.update_post(post[:url], {
        publishTimeMillis: timestamp,
        defaultBlogId: post[:blog_id]
      })
    end
  end

  def self.time_to_update(now, update_time)
    true
  end
end
