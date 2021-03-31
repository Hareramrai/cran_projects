class CreatePackages < ActiveRecord::Migration[6.0]
  def change
    create_table :packages do |t|
      t.string :name
      t.string :version
      t.string :r_version_needed
      t.string :dependencies
      t.timestamp :date_and_publication
      t.string :title
      t.string :authors
      t.string :maintainers
      t.string :license

      t.timestamps
    end
  end
end
