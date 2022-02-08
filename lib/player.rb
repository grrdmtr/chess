class Player
  attr_reader :color, :name

  def initialize(color, name = 'Pikachu')
    @name = name
    @color = color
  end
end
