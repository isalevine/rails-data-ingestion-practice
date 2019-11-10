require 'sinatra'
require 'json'

get '/' do
    i = 100
    hash = {}
    i.times do
        hash[i.to_s.to_sym] = true
        i -= 1
    end
    
    content_type :json
    hash.to_json
end