class CreateGithubUserTable < ActiveRecord::Migration
  def self.up
    create_table :github_users do |t|
      t.string :login, uniqueness: true
      t.string :name
      t.string :blog
      t.integer :plublic_repos
      t.integer :followers
      t.integer :following
    end
  end

  def self.down
    drop_table :github_users
  end
end
