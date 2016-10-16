class Note
  attr_reader :attributes

  def initialize(attributes={})
    @attributes = attributes
  end

  def to_hash
    @attributes
  end
end


class ToDoAppController < ActionController::Base
  def todo
    repository = Elasticsearch::Persistence::Repository.new do
      client Elasticsearch::Client.new url: 'http://localhost:9200', log: true
      index :mynotesindex
      type  :note
    end
    @allitems = repository.search('*').to_a.map(&:to_hash)
    @allitems.each do |item|
      p item
    end
  end
end

