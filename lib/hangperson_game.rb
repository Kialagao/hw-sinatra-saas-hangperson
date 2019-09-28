class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word
  attr_accessor :wrong_guesses
  attr_accessor :guesses
  
  def initialize(new_word) 
    @word = new_word
    @guesses = ''
    @wrong_guesses = ''
  end

  def guess(letter) 
    raise ArgumentError if (letter == nil || letter.size != 1 || !letter.match(/^[[:alpha:]]$/))
    
    letter.downcase!
    if (word.include? letter) 
      if guesses.include? letter
        return false
      end
      guesses << letter
    elsif !(wrong_guesses.include? letter)
      wrong_guesses << letter
    else
      return false
    end
    true
  end

  def word_with_guesses
    if guesses == ''
      word.gsub(/[a-zA-Z]/, '-')
    else
      word.gsub(/[^#{guesses}]/, '-')
    end
  end

  def check_win_or_lose
    if guesses.size != 0 && word =~ /^([#{@guesses}]*)$/
      return :win
    elsif wrong_guesses.size >= 7
      return :lose
    else
      return :play
    end
  end      
  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
