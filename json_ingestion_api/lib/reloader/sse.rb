require 'json'

module Reloader
    class SSE
        def initialize io
            @io = io
        end

        def write object
            @io.write JSON.dump(object)
        end

        def close
            @io.close
        end
    end
end