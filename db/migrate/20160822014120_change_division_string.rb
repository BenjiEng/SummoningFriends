class ChangeDivisionString < ActiveRecord::Migration
  def change
    change_column :friends, :division, :string
  end
end
