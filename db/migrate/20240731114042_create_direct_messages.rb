class CreateDirectMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :direct_messages do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.string :message

      t.timestamps
    end
  end
end
