class ChangeColumn < ActiveRecord::Migration
  def up
    change_column :friends, :division, :string
  end
end
