module ApplicationHelper
  def csrf_input
    csrf_html = <<-HTML
      <input
        type="hidden"
        name="authenticity_token"
        value="#{form_authenticity_token}">
      HTML
    csrf_html.html_safe
  end
end
