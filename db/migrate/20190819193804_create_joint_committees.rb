class CreateJointCommittees < ActiveRecord::Migration[5.2]
  def change
    create_table :joint_committees do |t|
      t.string :abbreviation
      t.string :name
      t.string :chair
      t.references :representative, foreign_key: true
      t.string :url
      t.string :chamber

      t.timestamps
    end
  end
end
