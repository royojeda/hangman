class Game
  attr_reader :remaining_guesses

  def initialize
    system 'clear'
    @remaining_guesses = 6
    show_remaining_guesses
    choose_word
  end

  def show_remaining_guesses
    puts "Remaining guesses: #{remaining_guesses}"
  end

  def choose_word
    words = File.open('google-10000-english-no-swears.txt', 'r') do |dictionary|
      dictionary.readlines.filter_map do |word|
        word.chomp if word.length.between?(6, 13)
      end
    end

    @secret_word = words[rand(0..(words.length - 1))]
  end
end

Game.new
