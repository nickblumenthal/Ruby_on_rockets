require 'webrick'
require_relative '../lib/phase8/controller_base'
require_relative '../lib/phase6/router'

class CatsController < Phase8::ControllerBase
  def index
    flash.now[:notice] = ['Flash Now Test']
    flash[:error] = ['Flash Later Test']
    @cats = "Test Cat"
  end

  def new
  end
end

router = Phase6::Router.new
router.draw do
  get Regexp.new("^/cats$"), CatsController, :index
  get Regexp.new("^/cats/new$"), CatsController, :new
end

server = WEBrick::HTTPServer.new(Port: 3000)
server.mount_proc('/') do |req, res|
  route = router.run(req, res)
end

trap('INT') { server.shutdown }
server.start
