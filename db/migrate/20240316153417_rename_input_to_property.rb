class RenameInputToProperty < ActiveRecord::Migration[7.1]
  def change
    create_table :properties do |t|
      t.integer  :price
      t.integer :balcony_num
      t.integer :bedroom_num
      t.string   :city
      t.integer   :total_floor
    end
  end
end
