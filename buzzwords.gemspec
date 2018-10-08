$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name                  = 'buzzwords'
  s.version               = '1.0.0'
  s.date                  = '2018-10-08'
  s.summary               = "A basic IRB tool to instantly generate the day's media buzzwords."
  s.description           = "A simple IRB tool that generates and displays the day's " +
                            "most popular buzzwords from news publications including " +
                            "The New York Times, The Washington Post, CNN, and Reuters."
  s.authors               = ['Elizabeth Tackett']
  s.email                 = 'emctackett@gmail.com'
  s.files                 = ['lib/buzzwords.rb', 'lib/buzzwords/cnn.rb', 'lib/buzzwords/ny_times.rb',
                             'lib/buzzwords/reuters.rb', 'lib/buzzwords/stopwords.rb',
                             'lib/buzzwords/washington_post.rb']
  s.homepage              = 'http://github.com/emctackett'
  s.license               = 'MIT'

  s.required_ruby_version = '~> 2.4.2'

  s.add_runtime_dependency 'mechanize'
  s.add_development_dependency 'rspec'
end
