require 'spec_helper'

describe MoviesController do
  describe 'Find Movies With Same Director' do
    it 'should call the model method that performs Movies With Same Director Search' do
#      if Movie.count > 0 then
#        p "#{Movie.count} movies available.... Movie.find_all_by_director should get called now!" 
#        Movie.should_receive(:find_all_by_director)
#        post :similar_movies, {:id => "1"}
#      else
#        p "NO movies available.... Can't call similar_movies...."
#      end
      fake_results = [mock('Movie1', :id=>1, :director=>'director1'), mock('Movie2', :id=>2, :director=>'director1')]
      Movie.stub(:find).and_return(fake_results[0])
      Movie.should_receive(:find_all_by_director).with('director1')
      post :similar_movies, {:id => "1"}
    end
    
    it 'should select the Similar Movies template for rendering' do
      fake_results = [mock('Movie1', :id=>1, :director=>'director1'), mock('Movie2', :id=>2, :director=>'director1')]
      Movie.stub(:find).and_return(fake_results[0])
      Movie.stub(:find_all_by_director).and_return(fake_results)
      post :similar_movies, {:id => "1"}
      response.should render_template('similar_movies')
    end
    
    it 'should make the Movies With Same Director Search Results available to that template' do
      fake_results = [mock('Movie1', :id=>1, :director=>'director1'), mock('Movie2', :id=>2, :director=>'director1')]
      Movie.stub(:find).and_return(fake_results[0])
      Movie.stub(:find_all_by_director).and_return(fake_results)
      post :similar_movies, {:id => "1"}
      # Check that Controller method has set @movies.
      assigns(:movies).should == fake_results
    end
  end
  
  describe 'cant find similar movies if we dont know director (sad path)' do
    it 'should select the home page template for rendering' do
      fake_results = mock('Movie1', :id=>1, :title=>'title1', :director=>'')
      Movie.stub(:find).and_return(fake_results)
      post :similar_movies, {:id => "1"}
      response.should redirect_to('/movies')
#      flash[:notice].should have_text("'#{fake_results.title}' has no director info")
      assert flash[:notice].match("'#{fake_results.title}' has no director info") != nil
    end
    
  end

end


