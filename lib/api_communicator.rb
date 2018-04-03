require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  # all_characters = RestClient.get('http://www.swapi.co/api/people/')
  # character_hash = JSON.parse(all_characters)
  character_array = get_all_characters
  all_films = films_by_character(character_array)
  character_films = films_for_given_character(all_films, character)
  urls_to_films(character_films)

  # iterate over the character hash to find the collection of `films` for the given
  #   `character`
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film
  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `parse_character_movies`
  #  and that method will do some nice presentation stuff: puts out a list
  #  of movies by title. play around with puts out other info about a given film.
end

def films_by_character(character_array)
  films_by_given_character = {}
   character_array.map { |character| films_by_given_character[character["name"]] = character["films"]}
    films_by_given_character
end

def films_for_given_character(film_hash, character_name)
  film_hash[character_name]
end

def urls_to_films(array_of_film_urls)
  array_of_film_urls.map do |film|
    film_info = RestClient.get(film)
    film_info_hash = JSON.parse(film_info)
  end
end

def parse_character_movies(films_info)
  films_info.map { |info| puts "Title: #{info["title"]}" }
  # some iteration magic and puts out the movies in a nice list
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

def get_count
  response = RestClient.get('http://www.swapi.co/api/people/')
  start_page = JSON.parse(response)
  count = (start_page["count"].to_f / 10).ceil
end

def get_all_characters
  count = get_count
  all_characters = []
  i = 1
  while i <= count
    response = RestClient.get('http://www.swapi.co/api/people/?page=' + i.to_s)
     current_page = JSON.parse(response)
     all_characters << current_page["results"]
     i += 1
  end
  all_characters.flatten
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
