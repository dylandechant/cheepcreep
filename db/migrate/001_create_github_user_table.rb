class CreateGithubUserTable < ActiveRecord::Migration
  def self.up
    create_table :github_user do |t|
      t.string :login
      t.string :name
      t.string :blog
      t.string :plublic_repos
      t.string :followers
      t.string :following
    end
  end

  def self.down
    drop_table :github_user
  end
end
