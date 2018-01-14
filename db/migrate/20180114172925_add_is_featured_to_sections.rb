class AddIsFeaturedToSections < ActiveRecord::Migration[5.1]
  def change
    add_column :sections, :is_featured, :boolean, :default => false, :null => false
  end
end
