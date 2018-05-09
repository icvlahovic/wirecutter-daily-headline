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
    puts "Hello! It's #{time.strftime("%A, %B %d, %Y")}. Here's today's headline from The Wirecutter:"
    sleep 1
    @article = WirecutterDailyHeadline::Article.today
  end

  def menu
    input = nil
    while input != "exit"
      puts <<~HEREDOC
        Choose from the following menu options:
        - To read the article in your console, enter "1"
        - To read the article in your browser, enter "2"
        - For more information about today's product(s), enter "3"
        - To purchase today's product(s), enter "4"
        - Type "exit" at any point to leave the application
      HEREDOC
      input = gets.strip
      if input == "1"
        WirecutterDailyHeadline::Article.display
      elsif input == "2"
        puts "Now redirecting you to your browser..."
        sleep 1
        WirecutterDailyHeadline::Article.redirect
      elsif input == "3"
        WirecutterDailyHeadline::Article.research
      elsif input == "4"
        WirecutterDailyHeadline::Article.prices
      elsif input == "exit"
        break
      else
        puts "Sorry, that's not a valid command!"
      end
    end
  end

  def goodbye
    puts "Thanks for reading! Until next time!"
  end

end
