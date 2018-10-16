require 'sinatra'
require 'sinatra/reloader' if development?
require 'pry-byebug'
require 'better_errors'
require_relative 'lib/cookbook'
require_relative 'lib/recipe'
require_relative 'lib/scrapeletscookfrenchservice'
# set :bind, '0.0.0.0'
configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  cookbook = Cookbook.new(File.join(__dir__, 'lib/recipes.csv'))
  @recipes = cookbook.all
  erb :index
end

post '/' do
  params.to_s
end

get '/recipe/:id' do
  cookbook = Cookbook.new(File.join(__dir__, 'lib/recipes.csv'))
  @recipes = cookbook.all
  @recipe = @recipes[params[:id].to_i]
  erb :recipe
end

get '/new' do
  erb :new
end

post '/recipes' do
  cookbook = Cookbook.new(File.join(__dir__, 'lib/recipes.csv'))
  recipe = Recipe.new(params[:name], params[:description], params[:cooktime], 'false', params[:difficulty])
  cookbook.add_recipe(recipe)
  redirect to '/'
end

get '/recipes/:index' do
  cookbook = Cookbook.new(File.join(__dir__, 'lib/recipes.csv'))
  cookbook.remove_recipe(params[:index].to_i)
  redirect '/'
end

get '/read/:index' do
  cookbook = Cookbook.new(File.join(__dir__, 'lib/recipes.csv'))
  cookbook.mark_read(params[:index].to_i)
  redirect to '/'
end

get '/import' do
  erb :import
end

post '/fetch' do
  # scraper = ScrapeLetsCookFrenchService.new(params[:ingredient])
  # @imported_recipes = scraper.call
end
