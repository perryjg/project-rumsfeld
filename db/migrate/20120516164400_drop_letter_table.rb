class DropLetterTable < ActiveRecord::Migration
  def up
  	drop_table :letters
  end

  def down
  end
end
