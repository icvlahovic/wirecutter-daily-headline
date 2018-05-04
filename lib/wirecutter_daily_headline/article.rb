class WirecutterDailyHeadline::Article

  attr_accessor :title, :author, :url

  def self.today
    @doc = Nokogiri::HTML(open("https://thewirecutter.com"))

    article = self.new
    article.title = @doc.search("h2.headline").first.text.strip
    article.author = @doc.search("p.author").first.text.strip
    article.url = @doc.search("a.headline-link").map {|link| link.text.strip}
    puts article.title
    puts article.author
    puts article.url
  end

end
