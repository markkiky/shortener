class CreateLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :links do |t|
      t.references :user, null: false, foreign_key: true
      t.text :url
      t.string :title
      t.string :favicon
      t.string :short_code
      t.date :expiry_date
      t.integer :clicks, default: 0
      t.boolean :validated, default: false
      t.boolean :deleted, default: false

      t.timestamps
    end
  end
end
