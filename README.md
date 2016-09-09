# Example of Refactoring with Ruby

This project goes about transforming an unstructured ruby script of a Guess
Game all the way up to separating it in different classes.

# Motivation

A Reddit user, that prefers to remain anonymous, reached me the
other day looking for help to refactor a script of hers in order to better
organize all the pieces of logic in the game.

Because there are many steps in refactoring a script like this, I've created
this git repository, trying to split every single step in a separate commit.

# Overview

From the moment I started editing the script, the overall steps were:

1. Simplify some of Ruby method calls
2. Separate pieces of logic into functions (global methods)
3. Reorganize lines of code, switching functions as deemed necessary
4. Organize some methods and variables into separate classes
5. Reorganize lines of code, creating new methods on abstractions as necessary

# When are we done with refactoring?

I could go on and on with further refactoring this code into a more elaborate
project. I could, for example, separate all the different classes in different
files. I stopped because I satisfied myself with the current level of
organization in the code.

Notice that, as a matter of fact, this is highly subjective. For example, one could
be satisfied with how the code looks like at the end of step 3 (commit `75870d7`).
This is a script with just functions, much shorter than the final result of this
refactoring.

Despite the bigger size, an object oriented code is easier to reason about and refactor,
as mutation and behaviour tend to be better separated by concern. It was easier, for example,
to figure `correctly_guess?` would fit as a method of `UserGuesses` in commit `ec30d6a`.

As your project grow in size, to be able to create abstractions and easily
refactor them is a game changer.

# Browsing the changes

To see the changes of this project in chronological order, clone this project and run:

    git log --patch --reverse

But if you prefer to use GitHub to view the changes, you can list the changes
in chronological order:

    git log --reverse --pretty='* [`%h`](https://github.com/thalesmello/ruby-example/commit/%h): %s'

For your convenience, those will be listed below:

* [`2f3c821`](https://github.com/thalesmello/ruby-example/commit/2f3c821): Initial version of guess game
* [`b0c0695`](https://github.com/thalesmello/ruby-example/commit/b0c0695): Instead of shuffling an entire array, I should probably use the sample method of an array to pick a random element
* [`8b9fcfb`](https://github.com/thalesmello/ruby-example/commit/8b9fcfb): Simplify iteration logic by quering the user input once
* [`e735859`](https://github.com/thalesmello/ruby-example/commit/e735859): Invert while loop logic for clarity
* [`1ccd858`](https://github.com/thalesmello/ruby-example/commit/1ccd858): Remove repeated if condition
* [`c7f0b03`](https://github.com/thalesmello/ruby-example/commit/c7f0b03): We can use an array of strings and then split just the word we choose. Easier to read
* [`5614659`](https://github.com/thalesmello/ruby-example/commit/5614659): Better yet, we can use %w string list notation to accomplish the same thing
* [`a6306e9`](https://github.com/thalesmello/ruby-example/commit/a6306e9): It's a good practice to use single quoted string (literal string) when we don't need special symbols
* [`8f2e007`](https://github.com/thalesmello/ruby-example/commit/8f2e007): It's a good practice to capitalize and add a space whenever you write a comment
* [`5541c7b`](https://github.com/thalesmello/ruby-example/commit/5541c7b): Replace exit condition by one liner
* [`f59aae3`](https://github.com/thalesmello/ruby-example/commit/f59aae3): Line is too long
* [`83a95b7`](https://github.com/thalesmello/ruby-example/commit/83a95b7): Use `loop do` instead of `while true` for infinite loop
* [`5e11006`](https://github.com/thalesmello/ruby-example/commit/5e11006): Use loop do instead of while true for infinite loops
* [`54ac194`](https://github.com/thalesmello/ruby-example/commit/54ac194): This is a bug fix. Previously your program was just replacing the first occurrence of the character. We then replace these two lines by a each_with_index loop that does the correct thing
* [`60cdd89`](https://github.com/thalesmello/ruby-example/commit/60cdd89): We are keeping track of the rounds by the `chances` variable. So, there is no need for a runtime variable
* [`eca3f66`](https://github.com/thalesmello/ruby-example/commit/eca3f66): Lets wrap all the code inside a function. That is the first step towards a better organization of code
* [`ab0e983`](https://github.com/thalesmello/ruby-example/commit/ab0e983): Get user input in separate function
* [`e631772`](https://github.com/thalesmello/ruby-example/commit/e631772): We can safely invert the order of the match comparison because string implements "=~"
* [`7b9506b`](https://github.com/thalesmello/ruby-example/commit/7b9506b): Separate guess validation from function that gets user input
* [`bfc2e4c`](https://github.com/thalesmello/ruby-example/commit/bfc2e4c): Extract welcome message to separate function
* [`b353a4b`](https://github.com/thalesmello/ruby-example/commit/b353a4b): Extract bouquet into a separate method
* [`3b4b81b`](https://github.com/thalesmello/ruby-example/commit/3b4b81b): Extract words into a separate function
* [`ccf1297`](https://github.com/thalesmello/ruby-example/commit/ccf1297): Extract print flowes to separate function
* [`9a473c1`](https://github.com/thalesmello/ruby-example/commit/9a473c1): Since we are checking for the guess length in the parsing process, it is not necessary to get the first one here, so we just use the single character string
* [`485de7d`](https://github.com/thalesmello/ruby-example/commit/485de7d): Export win game logic to separate function
* [`12dfff8`](https://github.com/thalesmello/ruby-example/commit/12dfff8): Simplify game loop logic by checking the chances in the while loop
* [`e37171c`](https://github.com/thalesmello/ruby-example/commit/e37171c): Further simplified exit game logic so it doesn't rely on exit calls
* [`0fd4839`](https://github.com/thalesmello/ruby-example/commit/0fd4839): Check if game finished in a separate function
* [`f00c19b`](https://github.com/thalesmello/ruby-example/commit/f00c19b): Moved print game over to its separate function
* [`e9bedd2`](https://github.com/thalesmello/ruby-example/commit/e9bedd2): Separate print lose point in a separate function
* [`c72e5e3`](https://github.com/thalesmello/ruby-example/commit/c72e5e3): Extract register user_guess into a separate logic
* [`73c172f`](https://github.com/thalesmello/ruby-example/commit/73c172f): Extract initial state to separate function
* [`1bc9612`](https://github.com/thalesmello/ruby-example/commit/1bc9612): Separate logic of when a guess is correct in a separate function
* [`44a9e1a`](https://github.com/thalesmello/ruby-example/commit/44a9e1a): Separate logic of when a guess is correct in a separate function
* [`42acadb`](https://github.com/thalesmello/ruby-example/commit/42acadb): Remove comments to make code clearer
* [`21ec4e5`](https://github.com/thalesmello/ruby-example/commit/21ec4e5): Reverting check game finished to the main function to make change variables in just one place
* [`409c977`](https://github.com/thalesmello/ruby-example/commit/409c977): Cleaning up some spaces, and now we are finally done. Wait, really?
* [`ea659d8`](https://github.com/thalesmello/ruby-example/commit/ea659d8): As a first step, let's wrap everything in a Guess class
* [`6585719`](https://github.com/thalesmello/ruby-example/commit/6585719): Group all print statements in a separate class. We are trying to group things that belong together
* [`953e029`](https://github.com/thalesmello/ruby-example/commit/953e029): Set initial state in the class initializer and remove the intial state metod
* [`9b91913`](https://github.com/thalesmello/ruby-example/commit/9b91913): Extract another method to the printer class
* [`81a5284`](https://github.com/thalesmello/ruby-example/commit/81a5284): Rename main class to reflect it is a game
* [`dfcb4c8`](https://github.com/thalesmello/ruby-example/commit/dfcb4c8): Turning private the methods of Printer that are not called outside the class
* [`618cf80`](https://github.com/thalesmello/ruby-example/commit/618cf80): Extract random word to separate class
* [`7f50ce8`](https://github.com/thalesmello/ruby-example/commit/7f50ce8): Extract handling of user guesses to separate class
* [`2b9eceb`](https://github.com/thalesmello/ruby-example/commit/2b9eceb): Forgot to remove words method from the game class
* [`4f87ba3`](https://github.com/thalesmello/ruby-example/commit/4f87ba3): Extract handling of under word to separate class
* [`19c1bff`](https://github.com/thalesmello/ruby-example/commit/19c1bff): Extract handling of chances in a separate class
* [`89ec266`](https://github.com/thalesmello/ruby-example/commit/89ec266): Extract game status logic to separate class
* [`0de026b`](https://github.com/thalesmello/ruby-example/commit/0de026b): Reorganize code inside the game class so actions are better separated
* [`d5a4abe`](https://github.com/thalesmello/ruby-example/commit/d5a4abe): Migrate logic of checking if guesses fill the word to UserGuesses class. Now everything is more separated, it is easier to see these relations.
* [`6739f26`](https://github.com/thalesmello/ruby-example/commit/6739f26): Separate validation of user_guess in a separate method
* [`7e50658`](https://github.com/thalesmello/ruby-example/commit/7e50658): Include README
* [`7717ceb`](https://github.com/thalesmello/ruby-example/commit/7717ceb): Include license file
* [`e22df21`](https://github.com/thalesmello/ruby-example/commit/e22df21): Include links in the README to make browsing the changes easier

