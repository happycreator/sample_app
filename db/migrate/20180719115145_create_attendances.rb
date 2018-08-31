class CreateAttendances < ActiveRecord::Migration[5.0]
  def change
    create_table :attendances do |t|
      t.datetime :arriving_at
      t.datetime :leaving_at
      t.text :note
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
