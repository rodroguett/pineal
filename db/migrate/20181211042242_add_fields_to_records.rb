class AddFieldsToRecords < ActiveRecord::Migration[5.2]
  def change
    add_column :records, :gerencia, :string
    add_column :records, :si, :string
    add_column :records, :cargo, :string
    add_column :records, :nvacantes, :integer
    add_column :records, :apto, :integer
    add_column :records, :noapto, :integer
    add_column :records, :encoordinacion, :string
    add_column :records, :integer, :string
    add_column :records, :npostulantes, :integer
    add_column :records, :diasconcurso, :integer
    add_column :records, :fechaapertura, :string
    add_column :records, :fechaaprobacion, :string
    add_column :records, :fechaaprobacionceo, :string
    add_column :records, :fechaingreso, :string
    add_column :records, :status, :string
    add_column :records, :comentario, :string
  end
end
