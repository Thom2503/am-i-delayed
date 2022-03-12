require 'net/http'
require 'json'
require 'pp'

uri = URI('https://gateway.apiportal.ns.nl/reisinformatie-api/api/v3/disruptions')

query = URI.encode_www_form({
    # Request parameters
    'type' => ['DISRUPTION'],
    'isActive' => 'true'
})
if query.length > 0
  if uri.query && uri.query.length > 0
    uri.query += '&' + query
  else
    uri.query = query
  end
end

request = Net::HTTP::Get.new(uri.request_uri)
# Request headers
request['Accept-Language'] = ''
# Request headers
request['Ocp-Apim-Subscription-Key'] = '{TOP_SECRET}'
# Request body
request.body = "{body}"
puts uri
response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
    http.request(request)
end

res = JSON.parse(response.body)
pp res
res.each do | disruption |
  puts disruption['title']
  puts disruption['type']
  puts disruption['timespans'][0]['situation']['label']
  puts disruption['expectedDuration']['description']
end
