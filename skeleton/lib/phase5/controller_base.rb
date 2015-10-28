require_relative '../phase4/controller_base'
require_relative './params'
require_relative './../bonus/flash'

module Phase5
  class ControllerBase < Phase4::ControllerBase
    attr_reader :params

    # setup the controller
    def initialize(req, res, route_params = {})
      @params = Params.new(req, route_params)
      super(req, res)
    end

    def redirect_to(url)
      super
      flash.store_flash(res)
    end

    def render_content(content, content_type)
      super
      flash.store_flash(res)
    end

    # method exposing a `Flash` object
    def flash
      @flash ||= Flash.new(req)
    end
  end
end
