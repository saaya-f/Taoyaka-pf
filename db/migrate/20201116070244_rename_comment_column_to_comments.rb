class RenameCommentColumnToComments < ActiveRecord::Migration[5.2]
  def change
    rename_column :comments, :comment, :tweet_comment
  end
end
