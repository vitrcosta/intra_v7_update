class FixColumnName < ActiveRecord::Migration[7.1]
  def self.up
    rename_column :clientes, :curso, :interesse
  end

  def self.down
  end
end
