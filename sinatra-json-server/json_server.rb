require 'sinatra'
require 'sinatra/streaming'
require 'json'
require 'securerandom'  # use SecureRandom.uuid to generate new unique id


# # use to test server
# get '/' do  
#     i = 100
#     hash = {}
#     i.times do
#         hash[i.to_s.to_sym] = true
#         i -= 1
#     end
    
#     content_type :json
#     hash.to_json
# end


name_array = ["Ryu", "Peco", "Rei", "Momo", "Garr", "Nina"]
hp_array = [132, 71, 15, 1, 0, 325]
magic_array = ["Frost", "Typhoon", "Magic Ball", "Ascension", "Rejuvinate", "Weretiger"]

get '/stream' do
    content_type :json

    stream do |out|
        5.times do
            character_hash = {
                "uuid": SecureRandom.uuid,
                "name": name_array.sample,
                "hp": hp_array.sample,
                "magic": magic_array.sample
            }
            out << character_hash.to_json unless out.closed?
            sleep 1
        end
    end

end