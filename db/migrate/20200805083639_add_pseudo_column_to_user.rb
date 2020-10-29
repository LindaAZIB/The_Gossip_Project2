class AddPseudoColumnToUser < ActiveRecord::Migration[5.2]
  def self.up
  	add_column :users, :pseudo, :string
  end

  def self.down
  	remove_column :users, :pseudo, :string
  end
end