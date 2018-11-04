class CreateUserPolls < ActiveRecord::Migration[5.1]
  def change
    create_table :user_polls do |t|
      t.references :user, foreign_key: true
      t.references :my_poll, foreign_key: true

      t.timestamps
    end
  end
end
