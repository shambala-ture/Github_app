class AddRepoUrlToUser < ActiveRecord::Migration
  def change
    add_column :users, :repo_url, :string
  end
end
