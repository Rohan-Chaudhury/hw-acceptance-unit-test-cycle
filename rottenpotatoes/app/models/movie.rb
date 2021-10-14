class Movie < ActiveRecord::Base
    def self.similar_director_movies movie_director
        if not movie_director.nil?
            return Movie.where(director: movie_director).all
        end
    end
end
