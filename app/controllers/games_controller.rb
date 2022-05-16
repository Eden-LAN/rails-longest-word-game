require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ('A'..'Z').to_a.sample
    end
  end

  def score
    input = params[:answer].upcase
    letters = params[:letters]
    @letters = letters.split(', ')
    results = ["Sorry, but #{input} can't be built out of #{letters}", "Sorry, but #{input} does not seem to be a valid English word...", "Congratulations, #{input} is a valid English word!"]
    url = "https://wagon-dictionary.herokuapp.com/#{input}"
    word_serialized = URI.open(url).read
    word = JSON.parse(word_serialized)
    @answer = results[2]
    @answer = results[1] unless word['found']

    @answer = results[0] unless input.chars.all? { |letter| @letters.include?(letter) }
  end
end
