# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# pro_publica_API_key = '4oZZxKDuDfCLINOYoq3rriQgVzTsyzDyz0Fw8OdV'
# open_secrets_API_key = 'cfa9bbaf09310e8550a687fa64d10751'

require 'csv'
csv_text = File.read(Rails.root.join('lib', 'seeds', 'state_data.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'ISO-8859-1')
csv.each do |row|
    t = State.new
    t.abbreviation = row['State Abbreviation']
    t.name = row['State Name']
    t.voter_turnout = row['Voter Turnout %']
    t.twenty_nineteen_election = row['2019 Election']
    t.twenty_nineteen_election_date = row['2019 Election Date']
    t.twenty_nineteen_election_type = row['2019 Election Type']
    t.twenty_nineteen_election_scope = row['2019 Election Scope']
    t.twenty_twenty_election = row['2020 Election']
    t.twenty_twenty_democratic_primary_date = row['2020 DEMOCRATIC Primary/Caucus Date']
    t.dem_primary_type = row['Democratic Primary/Caucus/Convention']
    t.twenty_twenty_republican_primary_date = row['2020 REPUBLICAN Primary/Caucus Date']
    t.rep_primary_type = row['Republican Primary/Caucus/Convention']
    t.twenty_twenty_general_election_date = row['2020 Gen Election Date']
    t.id_required = row['ID Required']
    t.early_or_in_person_absentee_voting = row['No-excuse Early Voting']
    t.early_or_in_person_absentee_voting_begins = row['Early voting/in person absentee voting begins']
    t.early_or_in_person_absentee_voting_ends = row['Early voting ends']
    t.automatic_voter_registration = row['Automatic Voter Registration?']
    t.same_day_voter_registration = row['Same day voter registration?']
    t.save
end