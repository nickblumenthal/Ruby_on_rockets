module Phase8
  class Flash
    def initialize(req)
      @req = req
      flash_cookie = req.cookies.find do |cookie|
        cookie.name == '_rails_lite_app_flash'
      end

      now_flash = flash_cookie.nil? ? {} : JSON.parse(flash_cookie.value)
      @now_flash = NowFlash.new(now_flash)
      @next_flash = {}
    end

    def []=(key, value)
      @next_flash[key.to_s] = value
    end

    def [](key)
      @now_flash[key.to_s]
    end

    def now
      @now_flash
    end

    def store_flash(res)
      # res.cookies.delete_if do |cookie|
      #   cookie.name == '_rails_lite_app_flash'
      # end
      byebug
      res.cookies << WEBrick::Cookie.new('_rails_lite_app_flash', @next_flash.to_json)
    end
  end

  class NowFlash
    def initialize(input_hash)
      @now_flash = input_hash
    end

    def []=(key, value)
      @now_flash[key.to_s] = value
    end

    def [](key)
      @now_flash[key.to_s]
    end
  end
end
