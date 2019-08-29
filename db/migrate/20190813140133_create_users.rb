class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :password_digest
      t.string :user_state
      t.references :state, foreign_key: true

      t.timestamps
    end
  end
end
