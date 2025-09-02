module DeviseHelper
  def auth_card(title, &block)
    render("devise/shared/auth_card", title:, content: capture(&block))
  end
end
