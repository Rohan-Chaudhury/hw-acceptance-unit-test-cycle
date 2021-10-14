class Movie < ActiveRecord::Base
    def self.similar_director_movies movie_director
        return Movie.where(director: movie_director).all
    end
end
