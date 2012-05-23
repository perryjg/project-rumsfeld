class CreateRequestTypes < ActiveRecord::Migration
  def up
    create_table :request_types do |t|
      t.string :name
      t.text :template

      t.timestamps
    end

    template = IO.read("{Rails.root}/lib/tasks/default_letter_template.txt")
    RequestType.create name: 'Generic', tmeplate: template
  end

  def down
  	drop_table :request_type
  end
end
