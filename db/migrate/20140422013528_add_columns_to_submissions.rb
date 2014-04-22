class AddColumnsToSubmissions < ActiveRecord::Migration
  def change
  	add_column :submissions, :title, :string
  	add_column :submissions, :textuser, :string
  	add_column :submissions, :audiouser, :string
  end
end
