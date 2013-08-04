class CreateHatebuEids < ActiveRecord::Migration
  def change
    create_table :hatebu_eids do |t|
      t.integer :eid
      t.integer :hatebu_category_id

      t.timestamps
    end
  end
end
