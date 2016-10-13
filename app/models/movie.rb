class Movie < ActiveRecord::Base
  
require	'themoviedb'


  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
# class Movie::InvalidKeyError < StandardError ; end
  
#  def self.find_in_tmdb(string)
#    begin
#      Tmdb::Movie.find(string)
#    rescue Tmdb::InvalidApiKeyError
#        raise Movie::InvalidKeyError, 'Invalid API key'
#    end
#  end



def self.find_in_tmdb(string)
    Tmdb::Api.key("f4702b08c0ac6ea5b51425788bb26562")
    begin
      Tmdb::Movie.find(string)
    rescue ArgumentError => tmdb_error
      raise Movie::InvalidKeyError, tmdb_error.message
    rescue RuntimeError => tmdb_error
      if tmdb_error.message =~ /status code '404'/
        raise Movie::InvalidKeyError, tmdb_error.message
      else
        raise RuntimeError, tmdb_error.message
      end
    end
end

end
