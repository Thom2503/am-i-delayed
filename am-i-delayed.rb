require 'net/http'
require 'net/smtp'
require 'time'
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

def sendMail(body)
  message = <<EOF
From: Your helper mailer <helloimmortarion@gmail.com>
To: Thom Veldhuis <{TO_EMAIL}>
MIME-Version: 1.0
Content-type: text/html
Subject: There are disruptions on your train line plan!
Date: #{Time.now.rfc2822}

<b>This is an automatic email.</b>
<h2>This is the disruption:</h2>
#{body}
EOF

  Net::SMTP.start('smtp.gmail.com', 587, user: 'helloimmortarion@gmail.com', secret: '{TOP_SECRET}', authtype: :login) do |smtp|
    smtp.send_message(message, 'helloimmortarion@gmail.com', '{TO_EMAIL}')
  end
end

sendMail(res)
