class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.text :text
      t.binary :recording

      t.timestamps
    end
  end
end
