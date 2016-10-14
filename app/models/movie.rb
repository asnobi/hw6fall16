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
    
    #Aziz
      movies = []
      Tmdb::Movie.find(string).each do |movie|
        movies << {:tmdb_id => movie.id, :title => movie.title, :rating => self._get_rating(movie.id), :release_date => movie.release_date}
      end
      return movies
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

#Aziz
def self.create_from_tmdb(tmdb_id)
    Tmdb::Api.key("f4702b08c0ac6ea5b51425788bb26562")
    detail = Tmdb::Movie.detail(tmdb_id)
    
    Movie.create(title: detail["original_title"], rating: self._get_rating(tmdb_id), release_date: detail["release_date"], description: detail["overview"])
end

#Aziz
def self._get_rating(tmdb_id)
    rating = ''
    Tmdb::Movie.releases(tmdb_id)["countries"].each do |r|
      if r["iso_3166_1"] == "US"
        rating = r["certification"]
        break
      end
    end
    return rating
end
end
