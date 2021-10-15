require 'rails_helper'

describe MoviesController do
    
    describe 'find Movies with same Director function' do
        let!(:movie_1) { Movie.create!(title: 'Star Wars', director: 'George Lucas') }
        let!(:movie_2) { Movie.create!(title: 'Blade Runner', director: 'Ridley Scott') }
        let!(:movie_3) { Movie.create!(title: 'Alien') }
        let!(:movie_4) { Movie.create!(title: 'THX-1138', director: 'George Lucas') }
        
        
        it 'should assign the list of movies with the same director if director exists' do
            get :similar, id: movie_1.id
            
            movies=[]
            
            for i in assigns(:sim_movies) 
                movies.append(i.title)
            end

            expect(movies).to eql(['Star Wars', 'THX-1138'])
        end
        
    
        it 'should not assign rest of the movies' do
            get :similar, id: movie_1.id
            
            movies=[]
            
            for i in assigns(:sim_movies) 
                movies.append(i.title)
            end

            expect(movies).not_to eql(['Blade Runner', 'Alien'])
        end
        
    
        
        it 'should display the similar.html.erb template of the movie if director exists' do
            get :similar, id: movie_1.id
            expect(response).to render_template('similar')
        end

        

        it 'should go back to index page if director does not exist' do
            get :similar, id: movie_3.id
            expect(response).to redirect_to(movies_path)
        end
    end

    describe 'index function' do
        let!(:movie_1) { Movie.create!(title: 'Star Wars', director: 'George Lucas') }
        let!(:movie_2) { Movie.create!(title: 'Blade Runner', director: 'Ridley Scott') }
        let!(:movie_3) { Movie.create!(title: 'Alien') }
        let!(:movie_4) { Movie.create!(title: 'THX-1138', director: 'George Lucas') }

        it 'should get all the movies to render' do
            get :index
            movies = []
            for i in assigns(:movies) 
                movies.append(i.title)
            end
            expect(movies).to eql(['Star Wars','Blade Runner','Alien', 'THX-1138'])
        end



        it 'should render index.html.erb template' do
            get :index
            expect(response).to render_template('index')
        end

    end   



    describe 'show function' do
        let!(:movie) { Movie.create!(title: 'Star Wars', director: 'George Lucas')}
        
        it 'should get the movie to show' do
            get :show, id: movie.id
            expect(@controller.instance_variable_get(:@movie)).to eql(movie)
        end
        
        

        it 'should render show.html.erb template of the movie' do
            get :show, id: movie.id
            expect(response).to render_template('show')
        end

    end
    

    
    describe 'new function' do
        let!(:movie) { Movie.new }
        it 'should display new.html.erb template' do
            get :new
            expect(response).to render_template('new')
        end
    end
    
    describe 'create function' do
        
        let!(:movie_1) { Movie.create!(title: 'Alien') }
        
        let!(:movie_2) { Movie.create!(title: 'THX-1138', director: 'George Lucas') }
        
        it 'should create a new movie' do
            post :create, movie: {title: 'Star Wars', director: 'George Lucas'}
            expect(Movie.count).to eql(3)
        end
        it 'should redirect to index page' do
            post :create, movie: {title: 'Star Wars', director: 'George Lucas'}
            
            expect(response).to redirect_to(movies_path)
        end
    end

    describe 'edit function' do
        
        let!(:movie) {  Movie.create!(title: 'Star Wars', director: 'George Lucas') }
        
        
        it 'should find the movie to edit' do
            
            get :edit, id: movie.id
            
            expect(@controller.instance_variable_get(:@movie)).to eql(movie)
        end
        
        it 'should render edit.html.erb template of the movie' do
            
            get :edit, id: movie.id
            
            expect(response).to render_template('edit')
        end
    end
    
    describe 'update function' do
        
        let(:movie) {  Movie.create!(title: 'Star Wars', director: 'George Lucas') }
        
        
        it 'should get the movie to update' do
            
            put :update, id: movie.id, movie:  {title: 'Blade Runner'}
            
            expect(@controller.instance_variable_get(:@movie)).to eql(movie)
        end

        
        
        it 'should update an existing movie title data' do
            
            put :update, id: movie.id, movie:  {title: 'Blade Runner'}
            
            movie.reload
            
            expect(movie.title).to eql('Blade Runner')
        end
        
        it 'should update an existing movie director data' do
            put :update, id: movie.id, movie:  {director: 'Ridley Scott'}
            movie.reload
            expect(movie.director).to eql('Ridley Scott')
        end

   
        it 'should redirect to the movie page' do
            
            put :update, id: movie.id, movie: {title: 'THX-1138', director: 'George Lucas'}
            
            expect(response).to redirect_to(movie_path(movie))
        end
    end
    
    describe 'destroy function' do
        
        let!(:movie_1) { Movie.create!(title: 'Star Wars', director: 'George Lucas') }
        let!(:movie_2) { Movie.create!(title: 'Blade Runner', director: 'Ridley Scott') }
        
        
        it 'should get the movie to delete' do
            
            delete :destroy, id: movie_1.id
            
            expect(@controller.instance_variable_get(:@movie)).to eql(movie_1)
        end

     
        
        it 'should delete the movie from the database' do
            
            delete :destroy, id: movie_1.id
            
            expect(Movie.count).to eq(1)
        end
        
        it 'should go back to index page' do
            
            delete :destroy, id: movie_1.id
            
            expect(response).to redirect_to(movies_path)
        end
    end
    
    
end