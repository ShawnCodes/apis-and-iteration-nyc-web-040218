require_relative "api_communicator.rb"


def welcome
  puts "Hi, welcome to the Starwars api"
  # puts out a welcome message here!
end

def get_character_from_user
  puts "please enter a character"
  character = gets.chomp
  # use gets to capture the user's input. This method should return that input, downcased.
end

def run_program
  welcome
  get_char = get_character_from_user
  get_movies = get_character_movies_from_api(get_char)
  parse_character_movies(get_movies)
end


run_program
