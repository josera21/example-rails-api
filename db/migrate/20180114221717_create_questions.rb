class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.references :my_poll, foreign_key: true
      t.text :description

      t.timestamps
    end
  end
end
