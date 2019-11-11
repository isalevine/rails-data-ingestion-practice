require 'reloader/sse'

class BroadcasterController < ApplicationController
    include ActionController::Live

    def index
        name_array = ["Ryu", "Peco", "Rei", "Momo", "Garr", "Nina"]
        hp_array = [132, 71, 15, 1, 0, 325]
        magic_array = ["Frost", "Typhoon", "Magic Ball", "Ascension", "Rejuvinate", "Weretiger"]

        response.headers['Content-Type'] = "text/event-stream"
        sse = Reloader::SSE.new(response.stream)

        begin
            5.times do      # this will batch together 5 json objects as one string, which need to be parsed by reloader_controller
                character_hash = {
                    "uuid": SecureRandom.uuid,
                    "name": name_array.sample,
                    "hp": hp_array.sample,
                    "magic": magic_array.sample
                }
                sse.write(character_hash)
                sleep 1
            end
        rescue IOError
            # client disconnected
        ensure
            sse.close
        end
    end
end