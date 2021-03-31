class AddDeletedAtToPackages < ActiveRecord::Migration[6.0]
  def change
    add_column :packages, :deleted_at, :datetime
    add_index :packages, :deleted_at
  end
end
