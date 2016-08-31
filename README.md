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

    git log --reverse --pretty="https://github.com/thalesmello/ruby-example/commit/%H"
