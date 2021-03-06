class CreateHouseCommittees < ActiveRecord::Migration[5.2]
  def change
    create_table :house_committees do |t|
      t.string :abbreviation
      t.string :name
      t.string :chair
      t.references :representative, foreign_key: true
      t.string :url
      t.string :subcommittees
      t.string :chamber

      t.timestamps
    end
  end
end
