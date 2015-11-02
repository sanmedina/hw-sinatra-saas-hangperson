class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  attr_reader :word_with_guesses
  attr_reader :check_win_or_lose
  
  def guess(letter)
    raise ArgumentError if not letter =~ /^[a-zA-Z]$/
    dletter = letter.downcase
    return false if (@guesses.include? dletter) || (@wrong_guesses.include? dletter)
    
    if @word.include? dletter
      @guesses += dletter
      @word_with_guesses = @word.gsub(/[^#{@guesses}]/, '-')
      @check_win_or_lose = :win if @word_with_guesses.eql?(@word)
    else
      @wrong_guesses += dletter
      @chances_left -= 1 if @chances_left > 0
      @check_win_or_lose = :lose if @chances_left <= 0
    end
    return true
  end
  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @word_with_guesses = word.gsub(/[a-zA-Z]/, '-')
    @chances_left = 7
    @check_win_or_lose = :play
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
