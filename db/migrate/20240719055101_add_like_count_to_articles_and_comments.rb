class AddLikeCountToArticlesAndComments < ActiveRecord::Migration[5.1]
  def change
    add_column :articles, :like_count, :integer, default: 0
    add_column :comments, :like_count, :integer, default: 0
  end
end
