module ProductsHelper
  TITLE_LENGTH = 25

  def title_trimmer(title)
    if title && title.length > TITLE_LENGTH
      title[0..TITLE_LENGTH] + "..."
    else
      title
    end
  end
end
