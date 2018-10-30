class AddCommitsUrlToUser < ActiveRecord::Migration
  def change
    add_column :users, :commits_url, :string
  end
end
