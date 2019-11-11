require 'net/http'

class ListenerController < ApplicationController
    def index
        response.headers['Content-Type'] = "application/json"

        url = URI.parse('http://localhost:3000/broadcaster')
        req = Net::HTTP::Get.new(url.to_s)
        res = Net::HTTP.start(url.host, url.port) {|http|
            http.request(req)
        }

        char_array = res.body.split("\n")
        char_array.each do |char_str|
            json = JSON.parse(char_str)
            Character.create("uuid": json["uuid"], "name": json["name"], "hp": json["hp"], "magic": json["magic"])
        end
    end
end