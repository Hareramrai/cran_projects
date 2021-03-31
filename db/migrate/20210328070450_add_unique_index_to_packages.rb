class AddUniqueIndexToPackages < ActiveRecord::Migration[6.0]
  def change
    add_index :packages, [:name, :version], unique: true
  end
end
