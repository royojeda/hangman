require_relative 'game'

system 'clear'

def ask_load
  puts 'Do you want to load a saved game? (y/n): '
  load_choice = gets.chomp.downcase

  case load_choice
  when 'y'
    File.open('save_file') do |f|
      Marshal.load(f)
    end
  when 'n'
    Game.new
  else
    system 'clear'
    puts 'Invalid choice.'
    ask_load
  end
end

current_game = ask_load
save = current_game.play

if save == true
  File.open('save_file', 'w+') do |f|
    Marshal.dump(current_game, f)
  end
end
