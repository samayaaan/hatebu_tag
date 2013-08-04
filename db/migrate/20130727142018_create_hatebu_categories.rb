class CreateHatebuCategories < ActiveRecord::Migration
  def change
    create_table :hatebu_categories do |t|
      t.string :category_name
      t.string :url

      t.timestamps
    end
  end
end
