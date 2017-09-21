# .frozen
module ImagesHelper
  def number_image(book, number)
    return image_default unless book.images.any? && book.images.offset(number).any?
    book.images.offset(number).first.file.url
  end

  def image_default
    'no-image.png'
  end
end
