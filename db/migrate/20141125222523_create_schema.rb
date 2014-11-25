class CreateSchema < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :token
      t.timestamps
    end
    create_table :projects do |t|
      t.string :name
      t.string :key
      t.string :status
      t.belongs_to :user
      t.timestamps
    end
    create_table :projects_users, id: false do |t|
      t.belongs_to :user
      t.belongs_to :project
    end
  end
end
