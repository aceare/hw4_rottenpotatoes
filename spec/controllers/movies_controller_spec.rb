require 'spec_helper'

describe MoviesController do
  describe 'Find Movies With Same Director' do
    it 'should call the model method that performs Movies With Same Director Search' do
#      Movie.should_receive(:find_similar_movies).with('hardware')
####### Above sets expectation, dynamically creates shadow/stub method, so that following line can call it!
####### NOTE: EVEN IF find_in_tmdb EXISTS, ABOVE WILL OVERRIDE IT!!
      post :similar_movies, {:id => 'hardware'}
    end
    it 'should select the Similar Movies template for rendering'
    it 'should make the Movies With Same Director Search Results available to that template' 
  end
end


