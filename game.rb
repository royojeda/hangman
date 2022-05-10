class Game
  attr_accessor :counter

  def initialize
    @guesses_left = 6
    @counter = 0
    load_dictionary
  end

  def load_dictionary
    words = File.open('google-10000-english-no-swears.txt', 'r') do |dictionary|
      dictionary.readlines.filter_map do |word|
        word.chomp if word.length.between?(6, 13)
      end
    end

    secret_word = words[rand(0..(words.length - 1))]

    p secret_word
  end

  private

  attr_reader :word
  attr_writer :guesses_left
end

Game.new
