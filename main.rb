class Game
  def initialize(word)
    @word = word
    @guesses_left = 6
  end

  private

  attr_reader :word
  attr_writer :guesses_left
end
