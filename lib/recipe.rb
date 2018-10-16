class Recipe
  attr_accessor :name, :description, :cooktime
  attr_reader :read, :difficulty
  def initialize(name, description, cooktime, read = false, difficulty = "")
    @name = name
    @description = description
    @cooktime = cooktime
    @read = read
    @difficulty = difficulty
  end

  def did_read!
    @read = true
  end
end
