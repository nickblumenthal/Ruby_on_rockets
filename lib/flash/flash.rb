class Flash
  def initialize(req)
    #byebug
    flash_cookie = req.cookies.find do |cookie|
      cookie.name == '_rails_lite_app_flash'
    end
    @now_flash = flash_cookie.nil? ? {} : JSON.parse(flash_cookie.value)

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
    byebug
    res.cookies << WEBrick::Cookie.new('_rails_lite_app_flash', @next_flash.to_json)
  end
end
