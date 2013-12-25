class ChangeScottOnVotes < ActiveRecord::Migration
  def change
  	change_table :votes do |t|
      t.change :scott, :boolean
    end
  end
end
