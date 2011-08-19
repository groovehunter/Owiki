class AddGlobalTermCount < ActiveRecord::Migration
  def self.up
    add_column :terms, :count, :integer
  end

  def self.down
    remove_column :count
  end
end
