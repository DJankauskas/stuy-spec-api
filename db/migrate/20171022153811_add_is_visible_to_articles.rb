class AddIsVisibleToArticles < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :is_visible, :boolean
  end
end
