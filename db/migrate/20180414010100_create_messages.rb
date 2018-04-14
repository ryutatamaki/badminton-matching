class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.references :user, foreign_key: true
      t.references :micropost, foreign_key: true
      t.string :comment

      t.timestamps
      
    end
  end
end
