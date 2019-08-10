class CreateSenators < ActiveRecord::Migration[5.2]
  def change
    create_table :senators do |t|
      t.string :name
      t.string :first_name
      t.string :last_name
      t.string :role
      t.string :gender
      t.string :chamber
      t.string :party
      t.string :new_york_times_url
      t.string :twitter_id
      t.string :facebook_account
      t.string :seniority
      t.string :next_election
      t.references :state, foreign_key: true

      t.timestamps
    end
  end
end
