class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.belongs_to :user, index:true
      t.references :element_liked, polymorphic:true
      t.timestamps
    end
  end
end
