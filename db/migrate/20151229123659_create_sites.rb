class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.text :url
      t.text :description
      t.text :source

      t.timestamps null: false
    end
  end
end
