# frozen_string_literal: true

require 'oauth2'
require 'dotenv'
require 'pp'
Dotenv.load

# Global base to make request to api
class Api42
  attr_reader :token, :client_id, :client_secret

  def initialize
    # config = YAML.load_file('secret.credentials.yml')
    @client_id = ENV['CLIENT_ID']
    @client_secret = ENV['CLIENT_SECRET']
    client = OAuth2::Client.new(@client_id, @client_secret, site: 'https://api.intra.42.fr')
    @token = client.client_credentials.get_token(scope: 'public projects')
  end

  def refresh_token
    client = OAuth2::Client.new(@client_id, @client_secret, site: 'https://api.intra.42.fr')
    @token = client.client_credentials.get_token
  end
end

class Coalition_user < Api42
  attr 'id', 'name', 'slug', 'image_url', 'color', 'user_id'

  def search(login)
    answer = @token.get("/v2/users/#{login}/coalitions").parsed[0]
    @id = answer['id']
    @name = answer['name']
    @slug = answer['slug']
    @image_url = answer['image_url']
    @color = answer['color']
    @user_id = answer['user_id']
  rescue
  end
end
