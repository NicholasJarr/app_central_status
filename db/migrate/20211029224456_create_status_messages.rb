class CreateStatusMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :status_messages do |t|
      t.string :message
      t.integer :status

      t.timestamps
    end
  end
end
