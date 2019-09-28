class CreateJoinTablePmRecipients < ActiveRecord::Migration[5.2]
  def change
    create_table :join_table_pm_recipients do |t|
    	t.references :received_message, index: true
    	t.references :recipient, index: true

      t.timestamps
    end
  end
end
