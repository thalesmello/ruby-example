def main
  print_welcome_message

  chances, word, under_word, all_guesses, game_finished = initial_state

  print_flowers(chances)

  while chances > 0 && !game_finished
    # Start with underscore 'word', will update with actual letters guessed
    # as it loops
    puts "Here is your word: #{under_word}"

    user_guess = get_user_guess(all_guesses)

    register_user_guess(user_guess, all_guesses)

    # When a correct letter is picked
    if word.include?(user_guess)
      game_finished = when_correct_guess(word, under_word, user_guess,
                                         all_guesses)
    else
      # If letter is incorrect, remove a petal
      chances -= 1
      print_point_lost(chances)

      # When there are no more chances left, player loses and program ends
      print_game_over(word) if chances == 0
    end
  end
end

def print_welcome_message
  puts "Welcome to Word Guess Game!
        The theme is: pets!"
  puts "The rules are as follows:
        Enter one letter at a time
        If correct, the letter will be filled in
        If incorrect, you will lose a petal
        If all your petals are gone, you lose
        If you guess all correct letters in Word you win!!!"
end

def initial_state
  chances = 5

  # Shuffle words in array and pick first element
  word = words.sample.split('')
  # Use the length of that word to create the right number of underscore spots
  under_word = ['_'] * word.length

  all_guesses = []

  game_finished = false

  [chances, word, under_word, all_guesses, game_finished]
end

def when_correct_guess(word, under_word, user_guess, all_guesses)
  puts 'YOU GUESSED A CORRECT LETTER!'

  # Replace the underscore with its correct letter value
  fill_under_word(under_word, word, user_guess)

  # When all letters are guess, player wins!
  check_game_finished(word, all_guesses)
end

def bouquet
  '
   \, \, |, /, /
       _\|/_
      |_____|
       |   |
       |___|
  '
end

def words
  %w( CAT
      DOG
      CHINCHILLA
      FERRET
      HAMSTER
      IGUANA
      SNAKE )
end

def print_flowers(chances)
  flower = '(@)'
  print flower * chances
  print bouquet
end

def get_user_guess(all_guesses)
  puts 'Enter one letter: '

  loop do
    user_guess = gets.chomp.upcase.to_s
    next unless parse_guess(user_guess, all_guesses)

    return user_guess
  end
end

def register_user_guess(user_guess, all_guesses)
  # Output the letter picked
  puts "You chose: #{user_guess}"
  # Put that letter into array of all letters guessed
  all_guesses << user_guess
  # Output all letters picked so far
  puts "\n\nHere are your letters so far : #{all_guesses}\n\n"
end

def parse_guess(guess, all_guesses)
  unless valid_guess? guess
    puts 'Invalid. Please enter a new letter:'
    return false
  end

  if all_guesses.include? guess
    puts "That's been guessed already. Please enter a new letter.\n\n"
    return false
  end

  true
end

def valid_guess?(guess)
  guess =~ /[A-Z]/ && guess.length == 1
end

def fill_under_word(under_word, word, user_guess)
  word.each_with_index do |letter, i|
    under_word[i] = letter if letter == user_guess
  end
end

def check_game_finished(word, all_guesses)
  return false unless win_game?(word, all_guesses)

  puts 'You win!'
  puts "The word is: #{word}"

  true
end

def win_game?(word, all_guesses)
  word.all? { |letter| all_guesses.include? letter }
end

def print_point_lost(chances)
  puts "THAT IS INCORRECT. You lose a petal!\n\n"
  print_flowers(chances)
end

def print_game_over(word)
  puts "\n\nYOU RAN OUT OF PETALS. YOU LOSE THE GAME\n\n\n"
  puts "The word was: #{word}"
end

main
