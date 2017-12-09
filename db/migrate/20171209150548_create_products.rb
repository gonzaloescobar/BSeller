class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.float :cost_price
      t.float :sale_price

      t.timestamps
    end
  end
end
