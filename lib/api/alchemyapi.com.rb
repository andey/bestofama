class AlchemyApi
  include HTTParty
  base_uri 'access.alchemyapi.com'

  def initialize
    # Lazy as shit ATM
    @apikey = '06e2540c449c3bb8d71dc002ca763b40b2c3aab7'
  end

  def TextGetRankedKeywords(text)
    options = {:query => {:apikey => @apikey, :text => text, :outputMode => 'json'}}
    response = self.class.post('/calls/text/TextGetRankedKeywords', options)
    return response.code == 200 ? JSON.parse(response.body) : nil
  end
end