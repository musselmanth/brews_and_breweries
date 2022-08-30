module Searchable

  def search_exact(search_phrase)
    self.where(name: search_phrase)
  end

  def search_partial(search_phrase)
    self.where("name ILIKE ?", "%#{sanitize_sql_like(search_phrase)}%")
  end

end