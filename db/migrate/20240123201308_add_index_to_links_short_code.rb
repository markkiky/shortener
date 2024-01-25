class AddIndexToLinksShortCode < ActiveRecord::Migration[7.1]
  def change
    add_index :links, :short_code, unique: true
  end
end
