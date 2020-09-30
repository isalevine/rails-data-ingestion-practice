require 'net/http'

class ListenerController < ApplicationController
    def index
        url = URI.parse('http://localhost:3000/broadcaster')
        
        Net::HTTP.start(url.host, url.port) do |http|
            request = Net::HTTP::Get.new(url.to_s)
            http.request(request) do |response|

                puts <<-READOUT

                res.read_body:
                ==============================

                READOUT

                response.read_body do |data_str|
                    if data_str != ""
                        data_hash = eval(data_str.slice!(6..-1))    # slice to remove leading "data: " substring
                        char_hash = data_hash[:character]
                        Character.create("uuid": char_hash[:uuid], "name": char_hash[:name], "hp": char_hash[:hp], "magic": char_hash[:magic])
                    end
                end
            end
        end
    end
end
