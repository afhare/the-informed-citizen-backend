class CreateSavedSenators < ActiveRecord::Migration[5.2]
  def change
    create_table :saved_senators do |t|
      t.references :user, foreign_key: true
      t.references :senator, foreign_key: true

      t.timestamps
    end
  end
end
