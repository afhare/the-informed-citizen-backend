require 'http'
require 'open-uri'
require 'json'
require 'pry'

class ProPublicaAPI
    PROPUBLICA_API_KEY = "4oZZxKDuDfCLINOYoq3rriQgVzTsyzDyz0Fw8OdV"
    
    SENATE_URL = "https://api.propublica.org/congress/v1/members/{chamber}/{state}/current.json"

   def test_API_search(chamber, state, district)
        if chamber == 'house'
            search_parameters = {chamber: chamber, state: state, district: district}
       search_parameters = {chamber: chamber, state: state}
       uri = URI.parse(URL)
       response = HTTP.auth(`X-API-Key: #{PROPUBLICA_API_KEY}`).get(uri, params: search_parameters)
       response.parse
   end
end

state_list = ['AL','AK','AZ','AR','CA','CO','CT','DE','FL','GA','HI','ID','IL','IN','IA','KS','KY','LA','ME','MD','MA','MI','MN','MS','MO','MT','NE','NV','NH','NJ','NM','NY','NC','ND','OH','OK','OR','PA','RI','SC','SD','TN','TX','UT','VT','VA','WA','WV','WI','WY']

state_list.each do |state|
    test = ProPublicaAPI.new.test_API_search(state, senate)
end


///////