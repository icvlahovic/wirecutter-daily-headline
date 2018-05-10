
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "wirecutter_daily_headline/version"

Gem::Specification.new do |spec|
  spec.name          = "wirecutter_daily_headline"
  spec.version       = WirecutterDailyHeadline::VERSION
  spec.authors       = ["icvlahovic"]
  spec.email         = ["banddorkfht7@gmail.com"]

  spec.summary       = %q{wirecutter-daily-headline lives up to its name, presenting The Wirecutter's daily headline article to you, the reader}
  spec.description   = %q{wirecutter-daily-headline has a few options: either read the article (and additional information) in your console (scraped with Nokogiri), or have Launchy redirect you to your browser, where you can read the article in its original form.}
  spec.homepage      = "https://github.com/icvlahovic/wirecutter-daily-headline"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency "nokogiri"
end
