class CreateRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :records do |t|
      t.string :vp
      t.string :rol

      t.timestamps
    end
  end
end
