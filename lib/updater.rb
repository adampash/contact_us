require 'kinja'
require 'dotenv'
Dotenv.load

class Updater
  POSTS = [
    {
      url: "http://gawker.com/dont-forget-you-can-email-us-tips-at-tips-gawker-com-1605185791",
      blog_id: 7
    },
    {
      url: "http://deadspin.com/have-something-you-think-we-should-know-email-us-at-ti-1695073772",
      blog_id: 11
    },
    # {
    #   url: "http://gawker.com/dont-forget-you-can-email-us-tips-at-tips-gawker-com-1605185791",
    #   blog_id: 7
    # },
  ]

  def self.client
    Kinja::Client.new(
      user: ENV["KINJA_USER"],
      password: ENV["KINJA_PASS"]
    )

  end

  def self.run
    return unless should_update?
    now = DateTime.now
    timestamp = now.strftime('%Q').to_i
    POSTS.each do |post|
      puts "Updating #{post[:url]}..."
      client.update_post(post[:url], {
        publishTimeMillis: timestamp,
        defaultBlogId: post[:blog_id]
      })
    end
  end

  def self.should_update?(date=DateTime.now)
    is_weekday?(date) or is_morning?(date)
  end

  def self.is_weekday?(date=DateTime.now)
    date.strftime('%u').to_i < 6
  end

  def self.is_morning?(date=DateTime.now)
    date.strftime('%k').to_i < 15
  end

  def self.time_to_update(now, update_time)
    true
  end
end
