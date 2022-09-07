#!/usr/bin/env ruby
# frozen_string_literal: true

require 'sinatra'
require 'omniauth'
require 'omniauth-marvin'

require_relative 'tools/api42'

# Static Background URL
metropolis_background = 'https://cdn.intra.42.fr/coalition/cover/64/Portada_Metropolis_2.jpg'
atlantis_background = 'https://cdn.intra.42.fr/coalition/cover/65/Portada_Atlantis_2.jpg'
wakanda_background = 'https://cdn.intra.42.fr/coalition/cover/66/Portada_Wakanda_2_min.jpg'

# enable sessions
configure do
  use Rack::Session::Pool
  set :show_exceptions, false
end

get '/' do
  erb :landing
end

post '/search' do
  @coa_user = Coalition_user.new
  @coa_user.search(params[:login])
  if @coa_user.name.nil?
    session[:user_not_found] = true
    redirect '/'
  else
    erb :user
  end
end

get '/*' do
  redirect '/'
end
