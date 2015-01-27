class CreateGithubUserTable < ActiveRecord::Migration
  def self.up
    create_table :github_users do |t|
      t.string :login, uniqueness: true
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
