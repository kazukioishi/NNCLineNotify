require 'net/http'

class LINENotifyAPI
  def initialize(token)
    @token = token
  end

  def post(mesg)
    uri = URI.parse('https://notify-api.line.me/api/notify')
    http = Net::HTTP.new(uri.host,uri.port)
    http.use_ssl = true
    req = Net::HTTP::Post.new(uri.path,{:Authorization => "Bearer #{@token}"})
    req.set_form_data({:message => mesg})
    res = http.request(req)
    case res
      when Net::HTTPSuccess
        return :OK
      else
        return :NG
    end
  end
end