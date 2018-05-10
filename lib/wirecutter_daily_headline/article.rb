require 'launchy'
require 'uri'

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
    today
    puts
    text = Nokogiri::HTML(open("#{@@article.url}"))
    alt_text = Nokogiri::HTML(open("#{@@article.url}"))

    text.css("section.lede p, div.heading h, section.intro > p").each do |e|
      puts e.text.strip unless e.text.strip == "Advertisement"
      puts
    end
    alt_text.css("section.post-content > h3, section.post-content > p, section.post-content li").each do |e|
      puts e.text.strip unless e.text.strip == "Advertisement"
      puts
    end
  end

  def self.redirect
    Launchy.open("#{@@article.url}")
  end

  def self.research
    puts
    text = Nokogiri::HTML(open("#{@@article.url}")).css("h2.chapter-heading, h3.chapter-heading, div.chapter-body > p, div#sources-panel li")

    output = text.each do |e|
      puts e.text.strip
      puts
    end
    sleep 0.5
    output > 0 ? nil : "Sorry, it appears there isn't any additional content today!"
    puts
  end

  def make_link(url)
    puts '<a href="' + url + '">' + url + '</a>'
  end

  def self.links
    links = Nokogiri::HTML(open("#{@@article.url}")).css("div.content p > a")
    links.map { |link| puts "#{link.text} - #{link['href'].strip}" }
  end

end
