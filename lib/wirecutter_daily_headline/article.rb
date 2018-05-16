require 'launchy'
# require 'uri'

class WirecutterDailyHeadline::Article

  attr_accessor :title, :author, :url, :text, :alt_text, :research, :links
  @@all = []

  def self.all
    @@all
  end

  def save
    @@all << self
  end

end
