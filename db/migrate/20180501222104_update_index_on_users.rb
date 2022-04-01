class UpdateIndexOnUsers < ActiveRecord::Migration
  def change
	def up
	  sql = 'DROP INDEX index_users_on_email'
	end
  end
end
