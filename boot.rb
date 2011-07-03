#require 'rubygems'
require 'bundler/setup'
Bundler.require(:default) if defined?(Bundler)

require File.expand_path('../config', __FILE__)

@consumer = OAuth::Consumer.new(
	CONSUMER_KEY,
	CONSUMER_SECRET,
	{:site => 'http://api.twitter.com'}
)

@access_token = OAuth::AccessToken.new(
	@consumer,
	ACCESS_TOKEN,
	ACCESS_SECRET
)

