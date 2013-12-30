# Set up gems listed in the Gemfile.
gemfile = ENV['BUNDLE_GEMFILE'] || File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(gemfile)
