class InitialSetup < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password
    
      t.timestamps      
    end

    create_table :events do |t|
      t.integer :user_id
      t.integer :category_id
      t.string :name
      t.integer :limit
      t.datetime :start
      t.datetime :end
      t.float :lat
      t.float :long
      
      t.timestamps 
    end

    create_table :categories do |t|
      t.string :name
    end
    
    create_table :attendings do |t|
      t.integer :user_id
      t.integer :event_id

      t.timestamps
    end
  end
end