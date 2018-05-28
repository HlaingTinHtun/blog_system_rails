class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :name
      t.string :email
      t.text :body

      t.timestamps null: false
    end
  end
end
