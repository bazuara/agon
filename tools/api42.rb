# frozen_string_literal: true

require 'oauth2'
require 'dotenv'
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
