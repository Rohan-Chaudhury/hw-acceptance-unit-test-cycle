require 'rails_helper'

describe Movie do
    describe '.similar_director_movies' do
        
        let!(:movie1) { Movie.create!(title: 'Star Wars', director: 'George Lucas') }
        let!(:movie2) { Movie.create!(title: 'Blade Runner', director: 'Ridley Scott') }
        let!(:movie3) { Movie.create!(title: 'Alien') }
        let!(:movie4) { Movie.create!(title: 'THX-1138', director: 'George Lucas') }
        
        context 'when director exists' do
        
          it 'finds movies with same director' do
            
            titlemovie1similar=[]
            titlemovie2similar=[]
            
            all_movie_1_similar=Movie.similar_director_movies(movie1.director)
            all_movie_2_similar=Movie.similar_director_movies(movie2.director)
            
            for i in all_movie_1_similar do
                titlemovie1similar.append (i.title)
            end
            
            for j in all_movie_2_similar do
                titlemovie2similar.append (j.title)
            end
            
            expect(titlemovie1similar).to eql(['Star Wars', 'THX-1138'])
            expect(titlemovie2similar).to eql(['Blade Runner'])
          end
        
         it 'does not find movies with same director' do
  
            titlemovie1similar=[]
            titlemovie2similar=[]
            
            all_movie_1_similar=Movie.similar_director_movies(movie1.director)
            all_movie_2_similar=Movie.similar_director_movies(movie2.director)
            
            for i in all_movie_1_similar do
                titlemovie1similar.append (i.title)
            end
            
            for j in all_movie_2_similar do
                titlemovie2similar.append (j.title)
            end          
        
            expect(titlemovie1similar).to_not include(['Blade Runner'])
            expect(titlemovie2similar).to_not include(['Star Wars', 'THX-1138'])
          end
        end
        
        
      context 'when director does not exist' do
        it 'does not return any movies' do
            
            titlemovie3similar=[]

            puts("asdasdasd")
            puts(Movie.similar_director_movies(movie3.director))
            all_movie_3_similar=Movie.similar_director_movies(movie3.director)

            if not all_movie_3_similar.nil?
                for i in all_movie_3_similar do
                    titlemovie3similar.append (i.title)
                end
            end
            

            expect(titlemovie3similar).to eql([])
         end
        end
        
    end
end