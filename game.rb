class Game
  attr_reader :tracker
  attr_accessor :guesses, :remaining_guesses

  GUESS_LIMIT = 6

  def initialize
    @guesses = []
    system 'clear'
    @remaining_guesses = GUESS_LIMIT
    show_remaining_guesses
    choose_word
    @tracker = Array.new(secret_word.length, '_')
    show_tracker
  end

  def play
    until remaining_guesses.zero?
      guesses[GUESS_LIMIT - remaining_guesses] = take_guess
      self.remaining_guesses -= 1
      system 'clear'
      show_remaining_guesses
      show_tracker
      p guesses
    end
  end

  def take_guess
    puts 'Enter a guess: '
    gets.chomp.downcase
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

  def show_tracker
    puts tracker.join(' ')
  end

  private

  attr_reader :secret_word
end

Game.new.play
