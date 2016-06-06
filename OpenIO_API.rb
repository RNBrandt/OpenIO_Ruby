require 'sinatra/base'

# sets the IP address post requests are sent to
set :port, #input ip Host address eg: "127.0.0.1:6010"

# get '/' do
#   'Hello World'
# end

class Api_request < Sinatra::Base
  def initialize(namespace, account_name, reference_name, content)
    @acct = account_name
    @namespace = namespace
    @ref = reference_name
    @path = content
    @
  end

  post "/v3.0/#{@namespace}/content/prepare" do
    @acct
    @ref
    @path
  end

  # post "/v3.0/#{@namespace}/content/get_properties" do
  #   @acct
  #   @ref
  #   @path
  # end

  # post "/v3.0/#{@namespace}/content/set_properties" do
  #   @acct
  #   @ref
  #   @path
  # end

  # post "/v3.0/#{@namespace}/content/del_properties" do
  #   @acct
  #   @ref
  #   @path
  # end

  run!
end
