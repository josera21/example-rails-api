class CreateMyApps < ActiveRecord::Migration[5.1]
  def change
    create_table :my_apps do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.string :app_id
      t.string :javascript_origins
      t.string :secret_key

      t.timestamps
    end
  end
end
