class CreateLinks < ActiveRecord::Migration[7.1]
  def change
    create_table :links do |t|
      t.references :user, null: false, foreign_key: true
      t.text :url
      t.string :title
      t.string :favicon
      t.string :short_code
      t.date :expiry_date
      t.integer :clicks
      t.boolean :validated
      t.boolean :deleted

      t.timestamps
    end
  end
end
