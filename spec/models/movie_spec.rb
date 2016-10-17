
describe Movie do
  describe 'searching Tmdb by keyword' do
    context 'with valid key' do
      it 'should call Tmdb with title keywords' do
        expect(Tmdb::Movie).to receive(:find).with('Inception')
        Movie.find_in_tmdb('Inception')
      end
      it 'should return empty if there is no result found in Tmdb' do
        expect(Tmdb::Movie).to receive(:find).with('Ali_Ali_Ali').and_return([])
        nothing = Movie.find_in_tmdb('Ali_Ali_Ali')
        expect(nothing).to eq([])
      end      
    end
    context 'with invalid key' do
      it 'should raise InvalidKeyError if key is missing or invalid' do
        allow(Tmdb::Movie).to receive(:find).and_raise(Tmdb::InvalidApiKeyError)
        expect {Movie.find_in_tmdb('Inception') }.to raise_error(Movie::InvalidKeyError)
      end
    end
  end
  describe 'check rate' do
    it 'should return a rate' do
      a = Tmdb::Movie.detail(66)
      
      expect(Tmdb::Movie).to receive(:releases).with(a['id']).and_return({'iso_3166_1' => 'US'})
      Movie.rate(a['id'])
    end
  end
  describe 'odd or even' do
    it 'should say odd' do
      fake= 'odd'
      expect(MoviesHelper).to receive(:oddness).with(4).and_return('even')
      fake = MoviesHelper.oddness(4)
      
    end
  end
  
  
end
