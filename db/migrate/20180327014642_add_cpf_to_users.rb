class AddCpfToUsers < ActiveRecord::Migration
  def change
    add_column :users, :cpf, :string, limit: 11
  end
end
