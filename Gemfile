source 'http://rubygems.org'
gemspec

group :test do
  # without ffaker in test it wont init
  # https://github.com/spree/spree/pull/833
  gem 'ffaker'
  gem 'shoulda-matchers'

  if RUBY_PLATFORM.downcase.include? "darwin"
    gem 'guard-rspec'
    gem 'rb-fsevent'
    gem 'growl'
  end
end

gem 'spree', '~> 1.2'
