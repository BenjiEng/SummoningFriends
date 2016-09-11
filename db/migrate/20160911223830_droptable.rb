class Droptable < ActiveRecord::Migration
  def up
    drop_table :recent_games
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
