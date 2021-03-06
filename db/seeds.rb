require 'rest-client'
require 'pry'
require 'csv'
require 'uri'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# google_API_Key = AIzaSyCWTpEcxECWnmZjKKQN_IkoKZad2G8x740
# pro_publica_API_key = '4oZZxKDuDfCLINOYoq3rriQgVzTsyzDyz0Fw8OdV'
# open_secrets_API_key = 'cfa9bbaf09310e8550a687fa64d10751'

JointCommittee.destroy_all
HouseCommittee.destroy_all
SenateCommittee.destroy_all
SavedSenator.destroy_all
SavedRepresentative.destroy_all
Senator.destroy_all
Representative.destroy_all
User.destroy_all
State.destroy_all


csv_text = File.read(Rails.root.join('lib', 'seeds', 'state-data.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
    state = State.new
    state.abbreviation = row['State Abbreviation']
    state.name = row['State Name']
    state.voter_turnout = row['Voter Turnout %']
    state.twenty_nineteen_election = row['2019 Election']
    state.twenty_nineteen_election_date = row['2019 Election Date']
    state.twenty_nineteen_election_type = row['2019 Election Type']
    state.twenty_nineteen_election_scope = row['2019 Election Scope']
    state.twenty_twenty_election = row['2020 Election']
    state.twenty_twenty_democratic_primary_date = row['2020 DEMOCRATIC Primary/Caucus Date']
    state.dem_primary_type = row['Democratic Primary/Caucus/Convention']
    state.twenty_twenty_republican_primary_date = row['2020 REPUBLICAN Primary/Caucus Date']
    state.rep_primary_type = row['Republican Primary/Caucus/Convention']
    state.twenty_twenty_general_election_date = row['2020 Gen Election Date']
    state.id_required = row['ID Required']
    state.early_or_in_person_absentee_voting = row['No-excuse Early Voting']
    state.early_or_in_person_absentee_voting_begins = row['Early voting or in person absentee voting begins']
    state.early_or_in_person_absentee_voting_ends = row['Early voting ends']
    state.automatic_voter_registration = row['Automatic Voter Registration?']
    state.same_day_voter_registration = row['Same day voter registration?']
    state.online_voter_registration = row['Online voter registration?']
    state.save
end

users = [
  {name: "Alex", username: "rabbitjustice", password: "pass123", user_state:"IL", state_id: State.find_by(abbreviation:"IL").id},
  {name: "Ana", username: "electhare", password: "pass456", user_state: "NY", state_id: State.find_by(abbreviation:"NY").id},
  {name: "Nate", username: "bunnyvoter", password: "pass789", user_state:"FL", state_id: State.find_by(abbreviation:"FL").id}
]

google_API_Key = 'AIzaSyCWTpEcxECWnmZjKKQN_IkoKZad2G8x740'

users.each do |user| 
    User.create(user)
end

#HOUSE REPS
PROPUBLICA_API_KEY = "4oZZxKDuDfCLINOYoq3rriQgVzTsyzDyz0Fw8OdV"

congressional_districts = [{:state_abbreviation=>"AL", :districts=>["1", "2", "3", "4", "5", "6", "7"]}, {:state_abbreviation=>"AK", :districts=>["1"]}, {:state_abbreviation=>"AZ", :districts=>["1", "2", "3", "4", "5", "6", "7", "8", "9"]}, {:state_abbreviation=>"AR", :districts=>["1", "2", "3", "4"]}, {:state_abbreviation=>"CA", :districts=>["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53"]}, {:state_abbreviation=>"CO", :districts=>["1", "2", "3", "4", "5", "6", "7"]}, {:state_abbreviation=>"CT", :districts=>["1", "2", "3", "4", "5"]}, {:state_abbreviation=>"DE", :districts=>["1"]}, {:state_abbreviation=>"DC", :districts=>["1"]}, {:state_abbreviation=>"FL", :districts=>["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27"]}, {:state_abbreviation=>"GA", :districts=>["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14"]}, {:state_abbreviation=>"HI", :districts=>["1", "2"]}, {:state_abbreviation=>"ID", :districts=>["1", "2"]}, {:state_abbreviation=>"IL", :districts=>["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18"]}, {:state_abbreviation=>"IN", :districts=>["1", "2", "3", "4", "5", "6", "7", "8", "9"]}, {:state_abbreviation=>"IA", :districts=>["1", "2", "3", "4"]}, {:state_abbreviation=>"KS", :districts=>["1", "2", "3", "4"]}, {:state_abbreviation=>"KY", :districts=>["1", "2", "3", "4", "5", "6"]}, {:state_abbreviation=>"LA", :districts=>["1", "2", "3", "4", "5", "6"]}, {:state_abbreviation=>"ME", :districts=>["1", "2"]}, {:state_abbreviation=>"MD", :districts=>["1", "2", "3", "4", "5", "6", "7", "8"]}, {:state_abbreviation=>"MA", :districts=>["1", "2", "3", "4", "5", "6", "7", "8", "9"]}, {:state_abbreviation=>"MI", :districts=>["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14"]}, {:state_abbreviation=>"MN", :districts=>["1", "2", "3", "4", "5", "6", "7", "8"]}, {:state_abbreviation=>"MS", :districts=>["1", "2", "3", "4"]}, {:state_abbreviation=>"MO", :districts=>["1", "2", "3", "4", "5", "6", "7", "8"]}, {:state_abbreviation=>"MT", :districts=>["1"]}, {:state_abbreviation=>"NE", :districts=>["1", "2", "3"]}, {:state_abbreviation=>"NV", :districts=>["1", "2", "3", "4"]}, {:state_abbreviation=>"NH", :districts=>["1", "2"]}, {:state_abbreviation=>"NJ", :districts=>["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]}, {:state_abbreviation=>"NM", :districts=>["1", "2", "3"]}, {:state_abbreviation=>"NY", :districts=>["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20",  "21", "22", "23", "24", "25", "26", "27"]}, {:state_abbreviation=>"NC", :districts=>["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13"]}, {:state_abbreviation=>"ND", :districts=>["1"]}, {:state_abbreviation=>"OH", :districts=>["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16"]}, {:state_abbreviation=>"OK", :districts=>["1", "2", "3", "4", "5"]}, {:state_abbreviation=>"OR", :districts=>["1", "2", "3", "4", "5"]}, {:state_abbreviation=>"PA", :districts=>["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18"]}, {:state_abbreviation=>"RI", :districts=>["1", "2"]}, {:state_abbreviation=>"SC", :districts=>["1", "2", "3", "4", "5", "6", "7"]}, {:state_abbreviation=>"SD", :districts=>["1"]}, {:state_abbreviation=>"TN", :districts=>["1", "2", "3", "4", "5", "6", "7", "8", "9"]}, {:state_abbreviation=>"TX", :districts=>["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36"]}, {:state_abbreviation=>"UT", :districts=>["1", "2", "3", "4"]}, {:state_abbreviation=>"VT", :districts=>["1"]}, {:state_abbreviation=>"VA", :districts=>["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"]}, {:state_abbreviation=>"WA", :districts=>["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]}, {:state_abbreviation=>"WV", :districts=>["1", "2"]}, {:state_abbreviation=>"WI", :districts=>["1", "2", "3", "4", "5", "6", "7", "8"]}, {:state_abbreviation=>"WY", :districts=>["1"]}, {:state_abbreviation=>"PR", :districts=>["1"]}, {:state_abbreviation=>"GU", :districts=>["1"]}, {:state_abbreviation=>"AS", :districts=>["1"]}, {:state_abbreviation=>"MP", :districts=>["1"]}, {:state_abbreviation=>"VI", :districts=>["1"]}]

congressional_districts.each do |state|
    #HOUSE REPRESENTATIVES
    state[:districts].each do |district|
        url = "https://api.propublica.org/congress/v1/members/house/#{state[:state_abbreviation]}/#{district}/current.json"

        response = RestClient::Request.execute(:method => :get, :url => url, headers: {'Content-Type': 'application/json', 'Accept': 'application/json', "X-API-Key": "#{PROPUBLICA_API_KEY}"})
        test_array = JSON.parse(response)
        results = test_array["results"]
        if results.length > 0
            representative = Representative.new
            representative.propublica_id = results[0]["id"]
            representative.name = results[0]["name"]
            representative.first_name = results[0]["first_name"]
            representative.last_name = results[0]["last_name"]
            representative.role = results[0]["role"]
            representative.chamber = "House of Representatives"
            representative.gender = results[0]["gender"]
            representative.party = results[0]["party"]
            representative.new_york_times_url = results[0]["times_topics_url"]
            representative.twitter_id = results[0]["twitter_id"]
            representative.facebook_account = results[0]["facebook_account"]
            representative.seniority = results[0]["seniority"]
            representative.next_election = results[0]["next_election"]
            representative.district = results[0]["district"]
            rep_state = State.find_by(abbreviation: state[:state_abbreviation])
            representative.state_id = rep_state.id
            representative.save
        else
            vacant_representative = Representative.new
            vacant_representative.name = "Vacancy"
            vacant_representative.contact_form = nil
            vacant_representative.phone = nil
            vacant_representative.dc_office = nil
            vacant_representative.propublica_id = nil
            vacant_representative.first_name = nil
            vacant_representative.last_name = nil
            vacant_representative.role = nil
            vacant_representative.chamber = "House of Representatives"
            vacant_representative.gender = nil
            vacant_representative.party = nil
            vacant_representative.new_york_times_url = nil
            vacant_representative.twitter_id = nil
            vacant_representative.facebook_account = nil
            vacant_representative.seniority = nil
            vacant_representative.next_election = nil
            vacant_representative.district = district
            vacant_rep_state = State.find_by(abbreviation: state[:state_abbreviation])
            vacant_representative.state_id = vacant_rep_state.id
            vacant_representative.save
        end
    end
end

# Representative.all.each do |representative|
#     rep_url = "https://api.propublica.org/congress/v1/members/#{representative.propublica_id}.json"
#     rep_response = RestClient::Request.execute(:method => :get, :url => rep_url, headers: {'Content-Type': 'application/json', 'Accept': 'application/json', "X-API-Key": "#{PROPUBLICA_API_KEY}"})
#     rep_array = JSON.parse(rep_response)
#     rep_results = rep_array["results"]
#     pry
#     rep_roles = rep_results[0]["roles"]
#     rep_roles.each do |congress|
#         if congress["congress"] == '116'
#             representative.contact_form = congress["contact_form"]
#             representative.dc_office = congress["office"]
#             representative.phone = congress["phone"]
#         end
#     end
# end

# SENATORS
congressional_districts.each do |state|
    senate_url = "https://api.propublica.org/congress/v1/members/senate/#{state[:state_abbreviation]}/current.json"

    senate_response = RestClient::Request.execute(:method => :get, :url => senate_url, headers: {'Content-Type': 'application/json', 'Accept': 'application/json', "X-API-Key": "#{PROPUBLICA_API_KEY}"})

    senate_test_array = JSON.parse(senate_response)
    senate_results = senate_test_array["results"]
    
    if senate_results.length > 0
        senate_results.each do |senator|
                senate_rep = Senator.new
                senate_rep.propublica_id = senator["id"]
                senate_rep.name = senator["name"]
                senate_rep.first_name = senator["first_name"]
                senate_rep.last_name = senator["last_name"]
                senate_rep.role = senator["role"]
                senate_rep.chamber = "Senate"
                senate_rep.gender = senator["gender"]
                senate_rep.party = senator["party"]
                senate_rep.new_york_times_url = senator["times_topics_url"]
                senate_rep.twitter_id = senator["twitter_id"]
                senate_rep.facebook_account = senator["facebook_account"]
                senate_rep.seniority = senator["seniority"]
                senate_rep.next_election = senator["next_election"]
                senate_rep_state = State.find_by(abbreviation: state[:state_abbreviation])
                senate_rep.state_id = senate_rep_state.id
                senate_rep.save
        end
    else
        case state[:state_abbreviation]
        when 'DC'
        when 'VI'
        when 'AS'
        when 'MP'
        when 'PR'
        when 'GU'
        else
            vacant_senator = Senator.new
            vacant_senator.contact_form = nil
            vacant_senator.phone = nil
            vacant_senator.dc_office = nil
            vacant_senator.propublica_id = nil
            vacant_senator.name = "Vacancy"
            vacant_senator.first_name = nil
            vacant_senator.last_name = nil
            vacant_senator.role = nil
            vacant_senator.chamber = "Senate"
            vacant_senator.gender = nil
            vacant_senator.party = nil
            vacant_senator.new_york_times_url = nil
            vacant_senator.twitter_id = nil
            vacant_senator.facebook_account = nil
            vacant_senator.seniority = nil
            vacant_senator.next_election = nil
            vacant_senator_state = State.find_by(abbreviation: state[:state_abbreviation])
            vacant_senator.state_id = vacant_senator_state.id
            vacant_senator.save
        end
    end
end

# Senator.all.each do |senator|
#     sen_url = "https://api.propublica.org/congress/v1/members/#{senator.propublica_id}.json"
#     sen_response = RestClient::Request.execute(:method => :get, :url => sen_url, headers: {'Content-Type': 'application/json', 'Accept': 'application/json', "X-API-Key": "#{PROPUBLICA_API_KEY}"})
#     sen_array = JSON.parse(sen_response)
#     sen_results = sen_array["results"]

#     sen_roles = sen_results[0]["roles"]
#     sen_roles.each do |congress|
#         if congress["congress"] == '116'
#             senator.contact_form = congress["contact_form"]
#             senator.dc_office = congress["office"]
#             senator.phone = congress["phone"]
#         end
#     end
# end

joint_comm_csv_text = File.read(Rails.root.join('lib', 'seeds', 'joint-committee-data.csv'))
joint_csv = CSV.parse(joint_comm_csv_text, :headers => true, :encoding => 'ISO-8859-1')
joint_csv.each do |row|
    joint_comm = JointCommittee.new
    joint_comm.abbreviation = row['Abbreviation']
    joint_comm.name = row['Name']
    joint_comm.chair = row['Chair']
    joint_comm.representative = Representative.find_by(id: row['Representative_id'])
    joint_comm.url = row['URL']
    joint_comm.chamber = row['Chamber']
    joint_comm.save
end

house_comm_csv_text = File.read(Rails.root.join('lib', 'seeds', 'house-committee-data.csv'))
house_csv = CSV.parse(house_comm_csv_text, :headers => true, :encoding => 'ISO-8859-1')
house_csv.each do |row|
    house_comm = HouseCommittee.new
    house_comm.abbreviation = row['Abbreviation']
    house_comm.name = row['Name']
    house_comm.chair = row['Chair']
    house_comm.representative = Representative.find_by(id: row['Representative_id'])
    house_comm.url = row['URL']
    house_comm.subcommittees = row['Subcommittees']
    house_comm.chamber = row['Chamber']
    house_comm.save
end

senate_comm_csv_text = File.read(Rails.root.join('lib', 'seeds', 'senate-committee-data.csv'))
senate_csv = CSV.parse(senate_comm_csv_text, :headers => true, :encoding => 'ISO-8859-1')
senate_csv.each do |row|
    senate_comm = SenateCommittee.new
    senate_comm.abbreviation = row['Abbreviation']
    senate_comm.name = row['Name']
    senate_comm.chair = row['Chair']
    senate_comm.senator = Senator.find_by(id: row['Senator_id'])
    senate_comm.url = row['URL']
    senate_comm.subcommittees = row['Subcommittees']
    senate_comm.chamber = row['Chamber']
    senate_comm.save
end