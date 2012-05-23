class CreateRequestTypes < ActiveRecord::Migration
  def change
    create_table :request_types do |t|
      t.string :name
      t.text :template

      t.timestamps
    end

    template = IO.read("#{Rails.root}/lib/tasks/default_letter_template.txt")
    RequestType.create name: 'Generic', template: template
  end
end
