source "https://rubygems.org"
ruby '2.3.3'
gem 'bundler'
%w[rspec rspec-core rspec-expectations rspec-mocks rspec-support].each do |lib|
  gem lib, :git => "git://github.com/rspec/#{lib}.git", :branch => 'master'
end
gem 'rack'
gem 'rspec-its', '~> 1.2'