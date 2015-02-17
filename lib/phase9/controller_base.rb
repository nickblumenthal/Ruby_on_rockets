require_relative '../phase8/controller_base'

module Phase9
  class ControllerBase < Phase8::ControllerBase

    def link_to(text, url, method = :get)
      html = "<a href=#{url}>#{text}</a>"
      return html
    end

    def button_to(text, url, method = :post)
      html = <<-HTML
        <form>
        <button
          type='submit'
          formaction="#{url}"
          formmethod="#{method}"
        >#{text}</button></form>
      HTML
    end
  end
end
