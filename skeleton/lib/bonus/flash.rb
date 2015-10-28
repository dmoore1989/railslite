require 'json'
require 'webrick'

module Phase5
  class Flash
    def initialize(req)
      req.cookies.each do |cookie|
        if cookie.name == '_flash' && cookie.path = "/"
          @flash = JSON.parse(cookie.value)
        end
      end

      @flash ||= {}
    end

    def [](key)
      @flash[key]
    end

    def []=(key, val)
      @flash[key] = val
    end

    def generate(type, text)
      @flash[type] = text
    end

    def store_flash(res)
      cookie = WEBrick::Cookie.new('_flash', @flash.to_json)
      res.cookies << cookie
    end
  end
end
