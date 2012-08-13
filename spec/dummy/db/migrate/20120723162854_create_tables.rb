class CreateTables < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :apn_device_token
    end

    create_table :notifications do |t|
      t.integer :receiver_id, null: false
      t.integer :sender_id, null: false

      t.integer :notifiable_id
      t.string :notifiable_type

      t.integer :target_id
      t.string :target_type

      t.boolean :apns
      t.boolean :apn_processed

      t.string :type
    end

    create_table :messages do |t|
      t.integer :sender_id
      t.integer :receiver_d
      t.string :mssage
    end
  end

  def down
    drop_table :users
    drop_table :notifications
    drop_table :messages
  end
end
