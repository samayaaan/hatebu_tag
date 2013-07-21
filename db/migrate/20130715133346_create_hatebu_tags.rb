class CreateHatebuTags < ActiveRecord::Migration
  def change
    create_table :hatebu_tags do |t|
      t.string :tag
      t.string :category

      t.timestamps
    end
  end
end
