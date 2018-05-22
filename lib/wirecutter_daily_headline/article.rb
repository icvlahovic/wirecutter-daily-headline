# require 'launchy'
# require 'uri'
class WirecutterDailyHeadline::Article

  attr_accessor :title, :author, :url, :text, :alt_text, :research, :links
  @@all = []

  # build an #initalize method that takes a hash as an argument
  # and creates an instance with that hash
  def initialize(attribute_hash)
    attribute_hash.each do |k, v|
      self.send "#{k}=", v
    end
    self.save
  end

  def self.all
    @@all
  end

  def save
    @@all << self
  end

end
