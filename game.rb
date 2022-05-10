class Game
  attr_reader :tracker
  attr_accessor :guess, :remaining_guesses

  def initialize
    system 'clear'
    @remaining_guesses = 6
    show_remaining_guesses
    choose_word
    @tracker = Array.new(secret_word.length, '_')
    show_tracker
  end

  def play
    until remaining_guesses.zero?
      take_guess
      self.remaining_guesses -= 1
      system 'clear'
      show_remaining_guesses
      show_tracker
    end
  end

  def take_guess
    puts 'Enter a guess: '
    self.guess = gets.chomp.downcase
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
