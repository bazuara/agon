#!/usr/bin/env ruby
# frozen_string_literal: true

require 'sinatra'
require 'omniauth'
require 'omniauth-marvin'

require_relative 'tools/api42'

cred = Api42.new

# enable sessions
configure do
  use Rack::Session::Pool
  set :show_exceptions, false
end

use OmniAuth::Builder do
  provider :marvin, cred.client_id, cred.client_secret
end

OmniAuth.config.on_failure = proc do |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
end

get '/' do
  cred.refresh_token
  erb :landing
end

get '/*' do
  redirect '/'
end
