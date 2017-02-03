require 'sinatra/base'
require './slack.rb'

class Application < Sinatra::Base
  use Slack
end