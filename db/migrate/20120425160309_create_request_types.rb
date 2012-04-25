class CreateRequestTypes < ActiveRecord::Migration
  def change
    create_table :request_types do |t|
      t.string :name
      t.text :template

      t.timestamps
    end
  end
end
