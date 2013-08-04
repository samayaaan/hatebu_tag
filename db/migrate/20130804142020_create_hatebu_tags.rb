class CreateHatebuTags < ActiveRecord::Migration
  def change
    create_table :hatebu_tags do |t|
      t.string :tag_name
      t.integer :hatebu_category_id
      t.integer :cnt

      t.timestamps
    end
  end
end
