class Requester
  include HTTParty
  base_uri 'http://api.addsheet.com/v3'
  # def initialize(key)
  # end

  def self.test
    self.get('/locations/').body
  end



end
