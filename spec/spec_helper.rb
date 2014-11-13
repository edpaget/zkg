$:.unshift File.expand_path '../../lib', __FILE__

require 'celluloid'
require 'http'
require 'json'

module TestHelpers
  def client
    HTTP
  end

  def base_url
    "http://localhost:80808"
  end
  
  attr_reader :response

  def default_headers
    { "Accept" => "application/vnd.api+json" }
  end

  def http_send(method, url, params: {}, body: "", headers: default_headers)
    url = base_url + url
    @response = client.with_headers(headers).send method,
                                                  url,
                                                  params: params,
                                                  body: body
  end

  def get(url, params={}, headers={})
    http_send(:get, url, params: params, headers: headers)
  end

  def json_response
    JSON.parse(response.to_s)
  end
end
