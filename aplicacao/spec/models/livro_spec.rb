# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Livro, type: :model do
  before(:all) do
    @livro = Livro.create(titulo: 'Titulo do livro', autor: 'Nome e Sobrenome', ano: 2000,
                          editora: 'Editora generica', edicao: 2, livro_eletronico: true)
  end

  it 'checks that a livro can be created' do
    expect(@livro).to be_valid
  end

  it 'checks that a livro can be read' do
    expect(Livro.find_by_titulo('Titulo do livro')).to eq(@livro)
  end

  it 'checks that a livro can be updated' do
    @livro.update(titulo: 'Novo titulo')
    expect(Livro.find_by_titulo('Novo titulo')).to eq(@livro)
  end

  it 'checks that a livro can be destroyed' do
    @livro.destroy
    expect(Livro.count).to eq(0)
  end

  after(:all) do
    @livro.destroy
  end
end
