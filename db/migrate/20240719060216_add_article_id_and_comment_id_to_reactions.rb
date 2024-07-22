class AddArticleIdAndCommentIdToReactions < ActiveRecord::Migration[5.1]
  def change
    add_column :reactions, :article_id, :integer
    add_column :reactions, :comment_id, :integer
  end
end
