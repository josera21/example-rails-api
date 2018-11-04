class CreateMyAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :my_answers do |t|
      t.references :user_poll, foreign_key: true
      t.references :answer, foreign_key: true

      t.timestamps
    end
  end
end
