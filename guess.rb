def main
  puts "Welcome to Word Guess Game!
        The theme is: pets!"
  puts "The rules are as follows:
        Enter one letter at a time
        If correct, the letter will be filled in
        If incorrect, you will lose a petal
        If all your petals are gone, you lose
        If you guess all correct letters in Word you win!!!"

  chances = 5
  flower = '(@)'

  bouquet = '
   \, \, |, /, /
       _\|/_
      |_____|
       |   |
       |___|
  '
  print flower * chances
  print bouquet

  words = %w( CAT
              DOG
              CHINCHILLA
              FERRET
              HAMSTER
              IGUANA
              SNAKE )
  # Shuffle words in array and pick first element
  word = words.sample.split('')
  # Use the length of that word to create the right number of underscore spots
  under_word = ['_'] * word.length

  # Run the program
  all_guesses = []
  loop do
    # Will run until no more chances, then program exits
    exit if chances == 0

    # Start with underscore 'word', will update with actual letters guessed
    # as it loops
    puts "Here is your word: #{under_word}"
    puts 'Enter one letter: '

    user_guess = get_user_guess(all_guesses)

    # Output the letter picked
    puts "You chose: #{user_guess[0]}"
    # Put that letter into array of all letters guessed
    all_guesses << user_guess[0]
    # Output all letters picked so far
    puts "\n\nHere are your letters so far : #{all_guesses}\n\n"

    # When a correct letter is picked
    if word.include?(user_guess)
      puts 'YOU GUESSED A CORRECT LETTER!'
      # Replace the underscore with its correct letter value
      word.each_with_index do |letter, i|
        under_word[i] = letter if letter == user_guess
      end

      # When all letters are guess, player wins!
      if word.all? { |e| all_guesses.include?(e) }
        puts 'You win!'
        puts "The word is: #{word}"
        exit
      end
    else
      # If letter is incorrect, remove a petal
      chances -= 1
      puts "THAT IS INCORRECT. You lose a petal!\n\n"
      print flower * chances
      print bouquet
      # When there are no more chances left, player loses and program ends
      if chances == 0
        puts "\n\nYOU RAN OUT OF PETALS. YOU LOSE THE GAME\n\n\n"
        puts "The word was: #{word}"
      end
    end
  end
end

def get_user_guess(all_guesses)
  # Initialize variable to preserve variable scope
  user_guess = nil
  # Check for letter
  loop do
    user_guess = gets.chomp.upcase.to_s
    break if user_guess =~ /[A-Z]/
    puts 'Invalid. Please enter a new letter: '
  end
  # Make sure it has not been guessed yet
  # Also if more than one letter is entered, only take the first
  while all_guesses.include?(user_guess[0])
    puts "That's been guessed already. Please enter a new letter.\n\n"
    user_guess = gets.chomp.upcase
  end
  user_guess
end

main
