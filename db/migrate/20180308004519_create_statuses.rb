class CreateStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :statuses do |t|
      t.text :body
      t.boolean :suspended, default: false

      t.timestamps
    end
  end
end
