require 'pry'

class WirecutterDailyHeadline::Scraper

  def scrape_article
    @doc = Nokogiri::HTML(open("https://thewirecutter.com"))
    @article = WirecutterDailyHeadline::Article.new

    @article.title = @doc.css("h2.headline")[0].text.strip
    @article.author = @doc.css("p.author")[0].text.strip
    @article.url = @doc.css("a.headline-link")[0]['href']

    content = Nokogiri::HTML(open("#{@article.url}"))
    @article.text = content.css("section.lede p, div.heading h, section.intro > p").map do |e|
      e.text.strip unless e.text.strip == "Advertisement"
    end
    @article.alt_text = content.css("section.post-content > h3, section.post-content > h4, section.post-content > p, section.post-content li").map do |e|
      e.text.strip unless e.text.strip == "Advertisement"
    end

    @article.research = content.css("h2.chapter-heading, h3.chapter-heading, div.chapter-body > p, div#sources-panel li").map do |e|
      e.text.strip
    end

    @article.links = content.css("div.content p > a, section.post-content p > a").map do |link|
      if link.text == link['href'].strip
        "#{link['href'].strip}"
      else
        "#{link.text} - #{link['href'].strip}"
      end
    end

    @article.save
    # binding.pry
  end

end
