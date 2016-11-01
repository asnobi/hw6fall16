require 'spec_helper'
require 'rails_helper'

describe MoviesController do
  describe 'searching TMDb' do
   it 'should call the model method that performs TMDb search' do
      fake_results = [double('movie1'), double('movie2')]
      expect(Movie).to receive(:find_in_tmdb).with('Ted').
        and_return(fake_results)
      post :search_tmdb, {:search_terms => 'Ted'}
    end
    it 'should select the Search Results template for rendering' do
      fake_results = [double('movie1'), double('movie2')]
      allow(Movie).to receive(:find_in_tmdb).and_return(fake_results)
      post :search_tmdb, {:search_terms => 'Ted'}
      expect(response).to render_template('search_tmdb')
    end  
    it 'should make the TMDb search results available to that template' do
      fake_results = [double('Movie'), double('Movie')]
      allow(Movie).to receive(:find_in_tmdb).and_return (fake_results)
      post :search_tmdb, {:search_terms => 'Ted'}
      expect(assigns(:movies)).to eq(fake_results)
    end
    it 'should know about invalid search' do
      fake_results = [double('Movie'), double('Movie')]
      allow(Movie).to receive(:find_in_tmdb).and_return (fake_results)
      post :search_tmdb, {:search_terms => nil}
      expect(response).to redirect_to '/movies'
    end
    it 'should the same argument in result page' do
      fake_results = [double('Movie'), double('Movie')]
      allow(Movie).to receive(:find_in_tmdb).and_return (fake_results)
      post :search_tmdb, {:search_terms => 'Ali'}
      expect(assigns(:search_terms)).to eq('Ali')
    end
   
    it 'should show Nothing is found on TMDb is there is no result' do
      post :search_tmdb, {:search_terms => 'Ali_Ali_Ali'}
      
      allow(Movie).to receive(:find_in_tmdb).and_return([])
      expect(response).to redirect_to(movies_path)
      expect(flash[:notice]).to eq("No matching movies were found on TMDb")
      
    end    

require 'spec_helper'
require 'rails_helper'

describe MoviesController do
  describe 'searching TMDb' do
   it 'should call the model method that performs TMDb search' do
      fake_results = [double('movie1'), double('movie2')]
      expect(Movie).to receive(:find_in_tmdb).with('Ted').
        and_return(fake_results)
      post :search_tmdb, {:search_terms => 'Ted'}
    end
    it 'should select the result to right render' do
      allow(Movie).to receive(:find_in_tmdb).and_return([1,2,3])
      post :search_tmdb, {:search_terms => 'Ted'}
      expect(response).to render_template('search_tmdb')
    end  
    it 'should make the TMDb search result to search_tmdb page' do
      fake_results = [double('movie1'), double('movie2')]
      allow(Movie).to receive(:find_in_tmdb).and_return (fake_results)
      post :search_tmdb, {:search_terms => 'Ted'}
      expect(assigns(:search_terms)).to eq('Ted')
    end
    it 'should know about invalid search cases' do
      fake_results = [double('movie1'), double('movie2')]
      allow(Movie).to receive(:find_in_tmdb).and_return (fake_results)
      post :search_tmdb, {:search_terms => nil}
      expect(response).to redirect_to '/movies'
    end
    it 'should have the same argument in result page' do
      fake_results = [double('movie1'), double('movie2')]
      allow(Movie).to receive(:find_in_tmdb).and_return (fake_results)
      post :search_tmdb, {:search_terms => 'Ali'}
      expect(assigns(:search_terms)).to eq('Ali')
    end
    it 'should show Nothing is found on TMDb if there is no result' do
      post :search_tmdb, {:search_terms => 'Ali_Ai_Ali'}
      
      allow(Movie).to receive(:find_in_tmdb).and_return([])
      expect(response).to redirect_to(movies_path)
      expect(flash[:notice]).to eq("No matching movies were found on TMDb")
      
    end 
  end
end
end
  describe 'add TMDbs movies' do
    before :each do
      @fake_results = [double('movie2')]
    end
    it 'should return to the movies page if nothing was selected' do
      
      
      post :add_tmdb, {}
      
      expect(flash[:notice]).to eq("No movies selected")
      expect(response).to redirect_to(movies_path)
      
    end

    it 'should call function find with 1' do
      expect(Movie).to receive(:find).with("66")
      get :edit, {:id => "66"}
    end  
end
  describe 'show movie' do
    it 'should call function find on Movie' do
      expect(Movie).to receive(:find).with("66")
      get :show, {:id => "66"}
    end
    it 'should render with show' do
      allow(Movie).to receive(:find)
      get :show, {:id => "66"}
      expect(response).to render_template('show')
    end
  end

  describe "update a movie from the database" do
    movie_new = {:title => "random title", :rating => "R", :description => "nothing", :release_date => "2016-12-10"}
    before(:each) do
      @movie = Movie.create! movie_new
    end
      update_param = {:title => "title updated"}
      
      it "should update the right movie" do
        allow(Movie).to receive(:update_attributes!).with(update_param)
        put :update, :id => @movie.id, :movie => update_param
      end
      it "should redirect to the movie page after it is done, update" do
        allow(Movie).to receive(:update).with(update_param)
        put :update, :id => @movie.id, :movie => update_param
        expect(response).to redirect_to(movie_path(@movie))
      end
    end
  
  describe "delete a movie" do
    movie_new = {:title => "random title", :rating => "R", :description => "nothing", :release_date => "2016-12-10"}
    before(:each) do
      @movie = Movie.create! movie_new
    end
      it "should delete the right movie" do
        expect { delete :destroy, :id => @movie.id}.to change(Movie, :count).by(-1)
      end
      it "should redirect to the movie page after it is done, delete" do
        delete :destroy, :id => @movie.id
        expect(response).to redirect_to(movies_path)
      end
    end

end

