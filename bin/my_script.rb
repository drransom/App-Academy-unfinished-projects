require 'addressable/uri'
require 'rest-client'

url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/users/1.json',
).to_s

puts RestClient.delete(url)

# begin
#   puts RestClient.post(url, {user: {name: "Gizmo", email: "gizmo@gizmo.com" } })
# rescue
#   puts "rest-client encountered error"
# end
