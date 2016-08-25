
puts "Welcome to Word Guess Game!
      The theme is: pets!"
puts "The rules are as follows:
      Enter one letter at a time
      If correct, the letter will be filled in
      If incorrect, you will lose a petal
      If all your petals are gone, you lose
      If you guess all correct letters in Word you win!!!"

chances = 5
flower = "(@)"

bouquet = '
 \, \, |, /, /
     _\|/_
    |_____|
     |   |
     |___|
'
print flower * chances
print bouquet


words = [ ["C", "A", "T"],
          ["D", "O", "G"],
          ["C", "H", "I", "N", "C", "H", "I", "L", "L", "A"],
          ["F", "E", "R", "R", "E", "T"],
          ["H", "A", "M", "S", "T", "E", "R"],
          ["I", "G", "U", "A", "N", "A"],
          ["S", "N", "A", "K", "E"]
        ]
# Shuffle words in array and pick first element
word = words.sample
#use the length of that word to create the right number of underscore spots
under_word = ["_"] * word.length

#run the program
runtime = word.length + chances
all_guesses = []
runtime.times do
  #will run until no more chances, then program exits
  if chances == 0
    exit
  end

  #start with underscore 'word', will update with actual letters guessed as it loops
  puts "Here is your word: #{under_word}"
  puts "Enter one letter: "

  #check for letter
  while true
    user_guess = gets.chomp.upcase.to_s
    break if /[A-Z]/.match(user_guess)
    puts "Invalid. Please enter a new letter: "
  end
  #make sure it has not been guessed yet
  #also if more than one letter is entered, only take the first
  until all_guesses.include?(user_guess[0]) == FALSE
    puts "That's been guessed already. Please enter a new letter.\n\n"
    user_guess = gets.chomp.upcase
  end

  #output the letter picked
  puts "You chose: #{user_guess[0]}"
  #put that letter into array of all letters guessed
  all_guesses << user_guess[0]
  #output all letters picked so far
  puts "\n\nHere are your letters so far : #{all_guesses}\n\n"

  #when a correct letter is picked
  if word.include?(user_guess)
    puts "YOU GUESSED A CORRECT LETTER!"
    #replace the underscore with its correct letter value
    if word.include?(user_guess)
      location = word.index(user_guess)
      under_word[location] = user_guess
    end
    #when all letters are guess, player wins!
    if word.all? { |e| all_guesses.include?(e) }
      puts "You win!"
      puts "The word is: #{word}"
      exit
    end
  else
    #if letter is incorrect, remove a petal
    chances -= 1
    puts "THAT IS INCORRECT. You lose a petal!\n\n"
    print flower * chances
    print bouquet
    #when there are no more chances left, player loses and program ends
    if chances == 0
      puts "\n\nYOU RAN OUT OF PETALS. YOU LOSE THE GAME\n\n\n"
      puts "The word was: #{word}"
    end
  end
end
