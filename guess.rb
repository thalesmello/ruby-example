# Controls the logic of the game
class GuessGame
  def initialize
    @printer = Printer.new
    @chances = Chances.new(5)
    @word = RandomWord.new.pick
    @under_word = UnderWord.new(@word)
    @user_guesses = UserGuesses.new
    @game_status = GameStatus.new(@word)
  end

  def run
    @printer.welcome
    @printer.chance_flowers(@chances.get)

    while @chances.positive? && !@game_status.finished?
      @printer.under_word(@under_word.get)
      user_guess = @user_guesses.prompt

      if @word.include?(user_guess)
        when_correct_guess(user_guess)
      else
        when_wrong_guess
      end
    end
  end

  def when_correct_guess(user_guess)
    puts 'YOU GUESSED A CORRECT LETTER!'

    @under_word.fill(user_guess)
    @game_status.check_win(@user_guesses.all)
  end

  def when_wrong_guess
    @chances.decrease
    @printer.point_lost(@chances.get)
    @printer.game_over(@word) if @chances.zero?
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

# Handle user chances in the game
class Chances
  def initialize(chances)
    @chances = chances
  end

  def get
    @chances
  end

  def zero?
    @chances == 0
  end

  def positive?
    @chances > 0
  end

  def decrease
    @chances -= 1
  end
end

# Checks if game if finished base on the completion of the word
class GameStatus
  def initialize(word)
    @finished = false
    @word = word
  end

  def finished?
    @finished
  end

  def check_win(all_guesses)
    return unless win_game?(all_guesses)

    puts 'You win!'
    puts "The word is: #{@word}"

    @finished = true
  end

  private

  def win_game?(all_guesses)
    @word.all? { |letter| all_guesses.include? letter }
  end
end

GuessGame.new.run
