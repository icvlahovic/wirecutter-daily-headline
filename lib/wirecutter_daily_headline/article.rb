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
    puts
    text = Nokogiri::HTML(open("#{@@article.url}")).search("section.lede p, section.intro > p")
    text.each do |e|
      puts e.text.strip if e.text.strip != "Advertisement"
      puts
    end
  end

  def self.redirect
    Launchy.open("#{@@article.url}")
  end

  def self.research
    puts
    text = Nokogiri::HTML(open("#{@@article.url}")).search("h2.chapter-heading, h3.chapter-heading, div.chapter-body p")
    text.each do |e|
      puts e.text.strip
      puts
    end
  end

  def self.prices
    info = Nokogiri::HTML(open("#{@@article.url}")).search("h3.product-name, h2.title, p.description, div.product-pricebox-sources")
    info.each do |e|
      puts e.text.strip
      puts
    end
    links = Nokogiri::HTML(open("#{@@article.url}")).search("div.product-pricebox-sources a")
    links.each do |link|
      @link = link
    end
  end

end
