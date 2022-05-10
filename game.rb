class Game
  attr_reader :tracker, :incorrect_guesses, :remaining_guesses, :current_guess

  GUESS_LIMIT = 6

  def initialize
    @current_guess = ''
    @incorrect_guesses = []
    @remaining_guesses = GUESS_LIMIT
    @secret_word = choose_word
    @tracker = Array.new(secret_word.length, '_')
  end

  def display
    system 'clear'
    show_remaining_guesses
    show_tracker
    show_incorrect_guesses
  end

  def play
    until remaining_guesses.zero?
      display
      current_guess = take_guess
      check_guess(current_guess)
      break if tracker == secret_word
    end

    game_end
  end

  def take_guess
    puts 'Enter a guess: '
    gets.chomp.upcase
  end

  def check_guess(guess)
    if secret_word.include?(guess)
      update_tracker(guess)
    else
      self.remaining_guesses -= 1
      incorrect_guesses.push(guess) unless incorrect_guesses.include?(guess)
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

    words[rand(0..(words.length - 1))].upcase.chars
  end

  def show_tracker
    puts "Secret Word: #{tracker.join(' ')}\n\n"
  end

  def game_end
    display
    if remaining_guesses.zero?
      puts "GAME OVER! You've run out of guesses.\n\nThe secret word was: #{secret_word.join.upcase}"
    else
      puts "CONGRATULATIONS! You've discovered the secret word!"
    end
    puts "\n"
  end

  private

  attr_reader :secret_word
  attr_writer :remaining_guesses, :current_guess
end

Game.new.play
