class Game
  attr_reader :tracker, :incorrect_guesses, :remaining_guesses, :guesses

  GUESS_LIMIT = 6

  def initialize
    @guesses = []
    @incorrect_guesses = []
    @remaining_guesses = GUESS_LIMIT
    choose_word
    @tracker = Array.new(secret_word.length, '_')
    display
  end

  def display
    system 'clear'
    show_remaining_guesses
    show_tracker
    show_incorrect_guesses
  end

  def play
    until remaining_guesses.zero?
      guesses[GUESS_LIMIT - remaining_guesses] = take_guess
      check_guess(guesses[GUESS_LIMIT - remaining_guesses])

      display
    end
  end

  def take_guess
    puts 'Enter a guess: '
    gets.chomp.downcase
  end

  def check_guess(guess)
    if secret_word.include?(guess)
      update_tracker(guess)
    else
      self.remaining_guesses -= 1
      incorrect_guesses.push(guess)
    end
  end

  def update_tracker(guess)
    secret_word.each_with_index do |letter, index|
      tracker[index] = guess if letter == guess
    end
  end

  def show_remaining_guesses
    puts "Remaining guesses: #{remaining_guesses}\n\n"
  end

  def show_incorrect_guesses
    puts "Incorrect guesses: #{incorrect_guesses}\n\n"
  end

  def choose_word
    words = File.open('google-10000-english-no-swears.txt', 'r') do |dictionary|
      dictionary.readlines.filter_map do |word|
        word.chomp if word.length.between?(6, 13)
      end
    end

    @secret_word = words[rand(0..(words.length - 1))].chars
  end

  def show_tracker
    puts "Secret Word: #{tracker.join(' ')}\n\n"
  end

  private

  attr_reader :secret_word
  attr_writer :remaining_guesses, :guesses
end

Game.new.play
