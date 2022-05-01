# frozen_string_literal: true

class CreateLivros < ActiveRecord::Migration[7.0] # rubocop:todo Style/Documentation
  def change
    create_table :livros do |t|
      t.string :titulo
      t.string :autor
      t.integer :ano
      t.string :editora
      t.integer :edicao
      t.boolean :livro_eletronico

      t.timestamps
    end
  end
end
