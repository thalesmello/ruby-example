# Controls the logic of the game
class GuessGame
  def initialize
    @printer = Printer.new
    @chances = 5
    @word = RandomWord.new.pick
    @under_word = UnderWord.new(@word)
    @user_guesses = UserGuesses.new
  end

  def run
    @printer.welcome
    @printer.chance_flowers(@chances)

    while @chances > 0 && !@game_finished
      @printer.under_word(@under_word.get)
      user_guess = @user_guesses.prompt

      if @word.include?(user_guess)
        when_correct_guess(@under_word, user_guess)
        @game_finished = check_game_finished(@word, @user_guesses.all)
      else
        @chances -= 1
        when_wrong_guess(@chances, @word)
      end
    end
  end

  def when_correct_guess(under_word, user_guess)
    puts 'YOU GUESSED A CORRECT LETTER!'

    under_word.fill(user_guess)
  end

  def when_wrong_guess(chances, word)
    @printer.point_lost(chances)
    @printer.game_over(word) if chances == 0
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

# Stores words and yields them randomly
class RandomWord
  def pick
    words.sample.split('')
  end

  private

  def words
    %w( CAT
        DOG
        CHINCHILLA
        FERRET
        HAMSTER
        IGUANA
        SNAKE )
  end
end

# Queries new user input and keeps track of it
class UserGuesses
  def initialize
    @all_guesses = []
  end

  def prompt
    puts 'Enter one letter: '

    loop do
      user_guess = gets.chomp.upcase.to_s
      next unless parse(user_guess)

      register(user_guess)

      return user_guess
    end
  end

  def all
    @all_guesses
  end

  def register(guess)
    puts "You chose: #{guess}"
    @all_guesses << guess
    puts "\n\nHere are your letters so far : #{@all_guesses}\n\n"
  end

  def parse(guess)
    unless valid? guess
      puts 'Invalid. Please enter a new letter:'
      return false
    end

    if @all_guesses.include? guess
      puts "That's been guessed already. Please enter a new letter.\n\n"
      return false
    end

    true
  end

  def valid?(guess)
    guess =~ /[A-Z]/ && guess.length == 1
  end
end

# Handles the filling of letters under the chosen word
class UnderWord
  def initialize(word)
    @word = word
    @under_word = ['_'] * @word.length
  end

  def get
    @under_word
  end

  def fill(user_guess)
    @word.each_with_index do |letter, i|
      @under_word[i] = letter if letter == user_guess
    end
  end
end

GuessGame.new.run
