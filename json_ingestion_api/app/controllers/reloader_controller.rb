require 'reloader/sse'
require 'net/http'

class ReloaderController < ApplicationController
    include ActionController::Live

    def index
        response.headers['Content-Type'] = "application/json"

        sse = Reloader::SSE.new(response.stream)

        begin
            url = URI.parse('http://localhost:4567/stream')
            req = Net::HTTP::Get.new(url.to_s)
            res = Net::HTTP.start(url.host, url.port) {|http|
                http.request(req)
            }
            sse.write(res.body) # output to console for debugging

            char_array = res.body.split("}")
            char_array.each do |char_str|
                json = JSON.parse(char_str + "}")
                Character.create("uuid": json["uuid"], "name": json["name"], "hp": json["hp"], "magic": json["magic"])
            end

        rescue IOError
        ensure
            sse.close
        end
    end
end