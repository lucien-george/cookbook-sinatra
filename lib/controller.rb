require_relative 'view'
require_relative 'scrapeletscookfrenchservice'
require_relative 'recipe'

class Controller
  def initialize(cookbook)
    @cookbook = cookbook
    @view = View.new
  end

  def list
    @view.display_recipes(@cookbook.all)
  end

  def create
    recipe = @view.create_recipe
    @cookbook.add_recipe(recipe)
  end

  def destroy
    index = @view.ask_for_index("Enter the # of the recipe you would like to destroy")
    @cookbook.remove_recipe(index)
    @view.destroy_approval(index)
  end

  def fetch_recipes
    keyword = @view.retrieve_keyword
    scraper = ScrapeLetsCookFrenchService.new(keyword)
    array = scraper.call
    @view.display_web_recipes(array)
    index = @view.ask_for_index("Which recipe would you like to import? (enter index)")
    @cookbook.add_recipe(Recipe.new(array[index][:title], array[index][:desc], array[index][:time], false, array[index][:diff]))
    @view.saving_recipe(array[index][:title])
  end

  def mark_as_read
    read_index = @view.ask_for_index("Enter index of recipe you want to mark as read")
    success = false
    if read_index < @cookbook.recipes.length
      @cookbook.mark_read(read_index)
      success = true
    end
    @view.mark_successful(success)
  end
end
