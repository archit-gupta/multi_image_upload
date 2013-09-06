class CreateTableImagesTags < ActiveRecord::Migration
  def change
    create_table :photos_tags do |t|
      t.references :photo
      t.references :tag
    end
  end
end
