require 'kinja'
require 'dotenv'
Dotenv.load

class Updater
  POSTS = [
    # {
    #   url: "http://gawker.com/dont-forget-you-can-email-us-tips-at-tips-gawker-com-1605185791",
    #   blog_id: 7
    # },
    {
      url: "http://deadspin.com/have-something-you-think-we-should-know-email-us-at-ti-1695073772",
      blog_id: 11
    },
    {
      url: "http://io9.com/just-a-reminder-you-can-email-us-news-and-info-any-tim-1695100689",
      blog_id: 8
    },
    {
      url: "http://kotaku.com/hey-listen-you-can-e-mail-us-tips-at-tips-kotaku-com-1695106732",
      blog_id: 9
    },
    {
      url: "http://jezebel.com/have-a-story-idea-or-some-information-you-think-we-shou-1707533526",
      blog_id: 39
    },
    {
      url: "http://gizmodo.com/don-t-forget-you-can-email-us-tips-at-tips-gawker-com-1763615386",
      blog_id: 4
    },
    # {
    #   url: "http://jalopnik.com/so-we-wrote-an-ebook-jalopnik-s-book-of-car-facts-and-1726631201",
    #   blog_id: 12
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
    five_before = (now.to_time - 300).to_datetime
    timestamp = five_before.strftime('%Q').to_i
    POSTS.each do |post|
      puts "Updating #{post[:url]}..."
      result = client.update_post(post[:url], {
        publishTimeMillis: timestamp,
        defaultBlogId: post[:blog_id]
      })
      puts result
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
