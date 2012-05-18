class AddLetterToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :letter, :text
  end
end
