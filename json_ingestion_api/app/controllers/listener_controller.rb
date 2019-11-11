require 'net/http'

class ListenerController < ApplicationController
    def index
        url = URI.parse('http://localhost:3000/broadcaster')
        req = Net::HTTP::Get.new(url.to_s)
        res = Net::HTTP.start(url.host, url.port) { |http| http.request(req) }

        puts <<-READOUT

    res.body:
    ==============================
    #{res.body}

        READOUT

        char_array = res.body.split("\n\n")
        char_array.each do |data_str|
            data_hash = eval(data_str.slice!(6..-1))    # slice to remove leading "data: " substring
            char_hash = data_hash[:character]
            Character.create("uuid": char_hash[:uuid], "name": char_hash[:name], "hp": char_hash[:hp], "magic": char_hash[:magic])
        end
    end
end