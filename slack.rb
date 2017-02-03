require 'sinatra/base'
require 'active_support'
require 'active_support/core_ext'
require './line.rb'

class Slack < Sinatra::Base
  post '/postline' do
    content_type :json
    res = {
        :text => nil,
        :attachments => []
    }
    if params[:text].blank?
      res[:text] = '(*ﾉω・*)Must have message,try again.'
      status 200
      return res.to_json
    end
    begin
      line = LINENotifyAPI.new(ENV['line_token'])
      res[:text] = line.post(params[:text]) == :OK ? '<(｀･ω･´)Sent LINE message.' : '(´・ω・`)Could not send LINE message.`'
      status 200
      return res.to_json
    rescue
      res[:text] = '(＠_＠;)Internal server error.'
      status 200
      return res.to_json
    end
  end
end