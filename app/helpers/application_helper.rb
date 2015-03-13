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

  def children_of(comment_id, comment_array)
    #returns all comments in comment_array with parent_id == comment_id.
    comment_array.select { |comment| comment.parent_comment_id == comment_id }
  end
end
