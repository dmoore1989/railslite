require 'json'
require 'webrick'

module Phase5
  class Flash
    def initialize(req)
      req.cookies.each do |cookie|
        if cookie.name == '_flash' && cookie.path = "/"
          @flash_now = JSON.parse(cookie.value)
        end
      end
      @flash = {}
      @flash_now ||= {}
    end

    def [](key)
      @flash_now[key]
    end

    def []=(key, value)
      @flash[key] = value
      @flash_now[key] = value
    end

    def now (key,value)
      @flash_now[key] = value
    end

    def messages
      messages = []
      @flash_now.each do |key, value|
        messages << "#{key}=> #{value}"
      end
      messages.join("<br>")
    end


    def store_flash(res)
      cookie = WEBrick::Cookie.new('_flash', @flash.to_json)
      res.cookies << cookie
    end
  end
end
