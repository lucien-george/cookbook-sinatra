class ScrapeLetsCookFrenchService # or ScrapeMarmitonService
  def initialize(keyword)
    @keyword = keyword
  end

  def call
    path = "http://www.letscookfrench.com/recipes/find-recipe.aspx?aqt=#{@keyword}"
    html_file = open(path).read
    html_doc = Nokogiri::HTML(html_file)
    recipes = []
    html_doc.search('.m_contenu_resultat').first(5).each do |element|
      title = element.search('.m_titre_resultat a').text.strip
      desc = element.search('.m_texte_resultat').text.strip
      time = element.search('.m_detail_time div:first-child').text.strip
      diff = element.search('.m_detail_recette').text.strip.split('-')[2]
      recipes << { title: title, desc: desc, time: time, diff: diff }
    end
    return recipes
  end
end
