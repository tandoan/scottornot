class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.text :url

      t.timestamps
    end
  end
end
