class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :hometown
      t.datetime :birthday

      t.timestamps null: false
    end
  end
end
