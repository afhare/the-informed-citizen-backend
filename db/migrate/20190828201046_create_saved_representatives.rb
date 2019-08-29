class CreateSavedRepresentatives < ActiveRecord::Migration[5.2]
  def change
    create_table :saved_representatives do |t|
      t.references :user, foreign_key: true
      t.references :representative, foreign_key: true

      t.timestamps
    end
  end
end
