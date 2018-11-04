class CreateMyPolls < ActiveRecord::Migration[5.1]
  def change
    create_table :my_polls do |t|
      t.references :user, foreign_key: true
      t.datetime :expires_at
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
