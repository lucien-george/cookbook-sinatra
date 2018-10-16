require_relative 'recipe'

class View
  def display_recipes(recipes)
    puts "-------------------------"
    puts "Here are all your recipes"
    puts "-------------------------"
    recipes.each_with_index do |recipe, recipe_index|
      is_read = recipe.read == "true" ? "x" : " "
      puts "#{recipe_index + 1}. [#{is_read}] #{recipe.name}: #{recipe.difficulty} (#{recipe.cooktime})"
    end
    puts "-------------------------"
  end

  def create_recipe
    puts "What recipe would you want to add?"
    print "> "
    name = gets.chomp
    puts "How would you describe \"#{name}\"?"
    print "> "
    description = gets.chomp
    puts "How much time would it take to cook \'#{name}\"?"
    print "> "
    time = gets.chomp
    puts "What is the difficulty?"
    print "> "
    diff = gets.chomp
    recipe = Recipe.new(name, description, time, false, diff)
    puts "Recipe Added to your cookbook"
    return recipe
  end

  def destroy_approval(index)
    puts "Your recipe ##{index + 1} was destroyed successfully"
  end

  def retrieve_keyword
    puts "What ingredient would you like a recipe for?"
    print "> "
    return gets.chomp
  end

  def display_web_recipes(array)
    array.each_with_index do |hash, hash_index|
      puts "#{hash_index + 1}. #{hash[:title]}"
    end
  end

  def saving_recipe(recipe_title)
    puts "Importing  \"#{recipe_title}\"..."
  end

  def ask_for_index(message)
    puts message
    print "> "
    return gets.chomp.to_i - 1
  end

  def mark_successful(success)
    puts success ? "Success" : "Invalid index"
  end
end
