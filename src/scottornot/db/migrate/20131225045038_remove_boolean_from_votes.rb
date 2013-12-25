class RemoveBooleanFromVotes < ActiveRecord::Migration
  def change
  	remove_column :votes, :boolean, :string
  end
end
