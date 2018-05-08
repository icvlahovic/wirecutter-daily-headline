require 'launchy'

class WirecutterDailyHeadline::Article

  attr_accessor :title, :author, :url

  @doc = Nokogiri::HTML(open("https://thewirecutter.com"))
  @@article = self.new
  @@article.title = @doc.css("h2.headline")[0].text.strip
  @@article.author = @doc.css("p.author")[0].text.strip
  @@article.url = @doc.css("a.headline-link")[0]['href']

  def self.today
    puts @@article.title
    puts @@article.author
  end

  def self.display
    text = Nokogiri::HTML(open("#{@@article.url}")).search("section.intro p")
    # Figure out how to remove last three elements (pertaining to newsletter options)
    text.each {|e| puts e.text.strip}
  end

  def self.redirect
    Launchy.open("#{@@article.url}")
  end

end
