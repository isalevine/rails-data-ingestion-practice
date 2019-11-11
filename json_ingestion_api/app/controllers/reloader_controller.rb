require 'reloader/sse'
require 'net/http'

class ReloaderController < ApplicationController
    include ActionController::Live

    def index
        # response.headers['Content-Type'] = "text/event-stream"
        response.headers['Content-Type'] = "application/json"

        sse = Reloader::SSE.new(response.stream)

        begin
            # loop do
            5.times do
                # sse.write({ :time => Time.now })

                url = URI.parse('http://localhost:4567/stream')
                req = Net::HTTP::Get.new(url.to_s)
                res = Net::HTTP.start(url.host, url.port) {|http|
                    http.request(req)
                }
                sse.write(res.body)

                sleep 1
            end
        rescue IOError
        ensure
            sse.close
        end
    end
end