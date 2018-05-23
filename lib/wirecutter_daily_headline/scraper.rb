# require 'pry'

class WirecutterDailyHeadline::Scraper

  def scrape_article
    @doc = Nokogiri::HTML(open("https://thewirecutter.com"))
    # insteach of calling Article.new here, create a hash of attributes
    # whose keys match the attribute names of an article
    # @article = WirecutterDailyHeadline::Article.new

    attribute_hash = {
    :title => @doc.css("h2.headline")[0].text.strip,
    :author => @doc.css("p.author")[0].text.strip,
    :url => @doc.css("a.headline-link")[0]['href']
    }

    @article = WirecutterDailyHeadline::Article.new(attribute_hash)
    # could we wait unil a user inputs for more info to do more scraping?
    # start with just what's above
  end

  def scrape_details(article)
   @content ||= Nokogiri::HTML(open("#{article.url}"))
   article.text ||= @content.css("section.lede p, div.heading h, section.intro > p").map do |e|
     e.text.strip unless e.text.strip == "Advertisement"
   end
   article.alt_text ||= @content.css("section.post-content > h3, section.post-content > h4, section.post-content > p, section.post-content li").map do |e|
     e.text.strip unless e.text.strip == "Advertisement"
   end

   article.research ||= @content.css("h2.chapter-heading, h3.chapter-heading, div.chapter-body > p, div[role=tablist] li, div#sources-panel li").map do |e|
     e.text.strip
   end

   article.links ||= @content.css("div.content p > a, section.post-content p > a").map do |link|
     if link.text == link['href'].strip
       "#{link['href'].strip}"
     else
       "#{link.text} - #{link['href'].strip}"
     end
   end
  end

end
