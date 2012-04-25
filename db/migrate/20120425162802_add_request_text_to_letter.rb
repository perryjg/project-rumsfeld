class AddRequestTextToLetter < ActiveRecord::Migration
  def change
    add_column :letters, :request_text, :text

  end
end
