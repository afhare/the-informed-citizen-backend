class CreateStates < ActiveRecord::Migration[5.2]
  def change
    create_table :states do |t|
      t.string :abbreviation
      t.string :name
      t.float :voter_turnout
      t.boolean :twenty_nineteen_election
      t.date :twenty_nineteen_election_date
      t.string :twenty_nineteen_election_type
      t.string :twenty_nineteen_election_scope
      t.boolean :twenty_twenty_election
      t.date :twenty_twenty_democratic_primary_date
      t.string :dem_primary_type
      t.date :twenty_twenty_republican_primary_date
      t.string :rep_primary_type
      t.date :twenty_twenty_general_election_date
      t.string :id_required
      t.boolean :early_or_in_person_absentee_voting
      t.date :early_or_in_person_absentee_voting_begins
      t.date :early_or_in_person_absentee_voting_ends
      t.boolean :automatic_voter_registration
      t.boolean :same_day_voter_registration

      t.timestamps
    end
  end
end
