class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text :text
      t.references :post, null: false, foreign_key: { to_table: :posts }
      t.references :author, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
