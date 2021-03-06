class Movie < ActiveRecord::Base
  
require	'themoviedb'


  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
class Movie::InvalidKeyError < StandardError ; end

  def self.find_in_tmdb(string)
    begin
      Tmdb::Api.key("f4702b08c0ac6ea5b51425788bb26562")
      movies = []
      movies_all = Tmdb::Movie.find(string)
      if (!movies_all.nil?)
        #a = Tmdb::Movie.casts(movies_all[0].id)
        movies_all.each do |movie|
          a = Tmdb::Movie.casts(movie.id)
          name= "none"
          
          a.present?
            name = ""
            a.each_with_index do |a,i|
              break if i==3
              if name == ""
                name = a['name']
              else
                name = name +" , "+ a['name']
              end
              
            end
            puts "#####"
          
          #puts movie.poster_path
          pic = "http://andreakihlstedt.com/wpsys/wp-content/uploads/2013/07/NO.jpg"
          if !movie.poster_path.blank?
            pic = "http://image.tmdb.org/t/p/w185/" + movie.poster_path
          end
          movies << {:tmdb_id => movie.id, :title => movie.title, :rating => self.rate(movie.id), :release_date => movie.release_date, :name => name, :pic => pic}
        end
        return movies
      else
        movies_all = []
        return movies_all
      end
      
    rescue Tmdb::InvalidApiKeyError
       raise Movie::InvalidKeyError, 'Invalid API key'
    end
  end


  def self.rate(tmdb_id)
    puts tmdb_id
    list_c = Tmdb::Movie.releases(tmdb_id)['countries']
    
      if(list_c != nil)
          rate = list_c.find_all {|m| m['iso_3166_1'] == 'US'  }
          
          if(rate != nil)
            
            rate.each do |r|
              if(self.all_ratings.include?(r['certification']))
                return r['certification']
              end
            end
            return '-'
          else
            return '-'
          end
      end
  end    
  
def self.create_from_tmdb(tmdb_id)
  begin
    Tmdb::Api.key("f4702b08c0ac6ea5b51425788bb26562")
    m_detail = Tmdb::Movie.detail(tmdb_id)
    puts "adding..............."
    Movie.create(title: m_detail["original_title"], rating: self.rate(tmdb_id) , release_date: m_detail["release_date"], description: m_detail["overview"])
  rescue Tmdb::InvalidApiKeyError
    raise Movie::InvalidKeyError, 'Invalid API key'
  end
end

end
