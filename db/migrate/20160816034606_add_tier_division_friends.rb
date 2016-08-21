class AddTierDivisionFriends < ActiveRecord::Migration
  def change
      add_column :friends, :tier, :string
      add_column :friends, :division, :integer
  end
end
