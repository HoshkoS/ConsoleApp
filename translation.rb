module Translation
  def translate(path, **values)
    puts I18n.t(path, **values)
  end
end
