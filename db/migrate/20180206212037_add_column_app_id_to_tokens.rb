class AddColumnAppIdToTokens < ActiveRecord::Migration[5.1]
  def change
    add_reference :tokens, :my_app, foreign_key: true
  end
end
