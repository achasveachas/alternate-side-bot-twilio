class AddSentToStatus < ActiveRecord::Migration[5.1]
  def change
    add_column :statuses, :sent, :boolean, default: false
  end
end
