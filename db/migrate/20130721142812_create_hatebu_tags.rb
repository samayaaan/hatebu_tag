class CreateHatebuTags < ActiveRecord::Migration
  def change
    create_table :hatebu_tags do |t|
      t.string :name
      t.integer :hatebu_catebory_id
      t.integer :cnt

      t.timestamps
    end
  end
end
