#!/usr/bin/env ruby
# frozen_string_literal: true

require 'sinatra'
require 'omniauth'
require 'omniauth-marvin'

require_relative 'tools/api42'

# Static Background URL

def coa_bg(id)
  metropolis_bg = 'https://cdn.intra.42.fr/coalition/cover/64/Portada_Metropolis_2.jpg'
  atlantis_bg = 'https://cdn.intra.42.fr/coalition/cover/65/Portada_Atlantis_2.jpg'
  wakanda_bg = 'https://cdn.intra.42.fr/coalition/cover/66/Portada_Wakanda_2_min.jpg'
  return metropolis_bg if id == 64
  return atlantis_bg if id == 65
  return wakanda_bg if id == 66
end

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
  @login = params[:login]
  @coa_user.search(@login)
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
