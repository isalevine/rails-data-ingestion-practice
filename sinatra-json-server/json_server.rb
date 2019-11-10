require 'sinatra'
require 'sinatra/streaming'
require 'json'
require 'securerandom'  # use SecureRandom.uuid to generate new unique id

name_array = ["Ryu", "Peco", "Rei", "Momo", "Garr", "Nina"]
hp_array = [132, 71, 15, 1, 0, 325]
magic_array = ["Frost", "Typhoon", "Magic Ball", "Ascension", "Rejuvinate", "Weretiger"]

get '/' do  # use to test server
    i = 100
    hash = {}
    i.times do
        hash[i.to_s.to_sym] = true
        i -= 1
    end
    
    content_type :json
    hash.to_json
end


get '/stream' do
    content_type :json
    
    stream do |out|
        # 60.times do
        #     out.puts Time.now
        #     out.puts "Hello World!", "How are you?"
        #     out.write "Written #{out.pos} bytes so far!"
        #     out.write "<br>"
        #     out.flush
        #     sleep 1
        # end

        # hash = {"is_json?": true}
        # out << hash.to_json

        60.times do
            character_hash = {
                "uuid": SecureRandom.uuid,
                "name": name_array.sample,
                "hp": hp_array.sample,
                "magic": magic_array.sample
            }
            out << character_hash.to_json
            sleep 1
        end
    end
end