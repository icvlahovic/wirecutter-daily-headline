require 'launchy'
require 'pry'

class WirecutterDailyHeadline::CLI

  def call
    headline
    sleep 1
    menu
    sleep 0.5
    goodbye
  end

  def headline
    time = Time.now
    puts
    puts "Hello! It's #{time.strftime("%A, %B %d, %Y")}. Here's today's headline from The Wirecutter:"
    sleep 0.5
    @article = WirecutterDailyHeadline::Scraper.new.scrape_article[0]
    puts @article.title
    puts @article.author
    puts
  end

  def menu
    input = nil
    while input != "exit"
      puts
      puts <<~HEREDOC
        Choose from the following menu options:
        - To read the article in your console, enter "1"
        - To read the article in your browser, enter "2"
        - For the research on today's product(s), enter "3"
        - For a list of links from today's article, enter "4"
        - Type "exit" at any point to leave the application
      HEREDOC
      puts
      input = gets.strip
      if input == "1"
        puts @article.text
      elsif input == "2"
        sleep 0.5
        puts
        puts "Now redirecting you to your browser..."
        puts
        sleep 1
        Launchy.open("#{@article.url}")
      elsif input == "3"
        puts @article.research
      elsif input == "4"
        puts @article.links
      elsif input == "exit"
        break
      else
        sleep 0.5
        puts
        puts "Sorry, that's not a valid command!"
        puts
      end
      # binding.pry
    end
  end

  def goodbye
    puts
    puts "Thanks for reading! See you tomorrow with another headline!"
  end

end
