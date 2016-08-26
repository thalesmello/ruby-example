# Controls the logic of the game
class GuessGame
  def initialize
    @printer = Printer.new
    @chances = 5
    @word = words.sample.split('')
    @under_word = ['_'] * @word.length
    @all_guesses = []
  end

  def run
    @printer.welcome
    @printer.chance_flowers(@chances)

    while @chances > 0 && !@game_finished
      @printer.under_word(@under_word)
      user_guess = get_user_guess(@all_guesses)
      register_user_guess(user_guess, @all_guesses)

      if @word.include?(user_guess)
        when_correct_guess(@word, @under_word, user_guess)
        @game_finished = check_game_finished(@word, @all_guesses)
      else
        @chances -= 1
        when_wrong_guess(@chances, @word)
      end
    end
  end

  def when_correct_guess(word, under_word, user_guess)
    puts 'YOU GUESSED A CORRECT LETTER!'

    fill_under_word(under_word, word, user_guess)
  end

  def when_wrong_guess(chances, word)
    @printer.point_lost(chances)
    @printer.game_over(word) if chances == 0
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

  def get_user_guess(all_guesses)
    puts 'Enter one letter: '

    loop do
      user_guess = gets.chomp.upcase.to_s
      next unless parse_guess(user_guess, all_guesses)

      return user_guess
    end
  end

  def register_user_guess(user_guess, all_guesses)
    puts "You chose: #{user_guess}"
    all_guesses << user_guess
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
end

# Prints messages of the game
class Printer
  def welcome
    puts "Welcome to Word Guess Game!
          The theme is: pets!"

    puts "The rules are as follows:
          Enter one letter at a time
          If correct, the letter will be filled in
          If incorrect, you will lose a petal
          If all your petals are gone, you lose
          If you guess all correct letters in Word you win!!!"
  end

  def under_word(word)
    puts "Here is your word: #{word}"
  end

  def chance_flowers(chances)
    flower = '(@)'
    print flower * chances
    print bouquet
  end

  def point_lost(chances)
    puts "THAT IS INCORRECT. You lose a petal!\n\n"
    chance_flowers(chances)
  end

  def game_over(word)
    puts "\n\nYOU RAN OUT OF PETALS. YOU LOSE THE GAME\n\n\n"
    puts "The word was: #{word}"
  end

  private

  def bouquet
    '
     \, \, |, /, /
         _\|/_
        |_____|
         |   |
         |___|
    '
  end
end

GuessGame.new.run
