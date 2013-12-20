class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.text :session
      t.references :picture, index: true
      t.string :scott
      t.string :boolean

      t.timestamps
    end
  end
end
