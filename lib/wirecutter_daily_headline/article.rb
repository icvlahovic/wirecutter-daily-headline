class WirecutterDailyHeadline::Article

  attr_accessor :title, :author, :url

  def self.today
    article = self.new
    article.title = "The Best VR Headsets for PC"
    article.author = "Signe Brewster"
    article.url = "https://thewirecutter.com/reviews/best-desktop-virtual-reality-headset/"
    puts article.title
  end

end
