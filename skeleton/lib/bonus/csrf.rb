module Phase5
  class CSRF
    def initialize(req)
      # unless req.request_method == "POST"
        req.cookies.each do |cookie|
          if cookie.name == '_csrf' && cookie.path = "/"
            @token = JSON.parse(cookie.value)
          end
        end
      # end
      @token ||= CSRF.generate_csrf_token
    end

    def self.generate_csrf_token
      {'csrf' => SecureRandom::urlsafe_base64}
    end

    def auth_token
      @token['csrf']
    end

    def store_csrf(res)

      cookie = WEBrick::Cookie.new('_csrf', @token.to_json)
      res.cookies << cookie
    end
  end
end
