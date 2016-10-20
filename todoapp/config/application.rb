require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Todoapp
  class Application < Rails::Application
    config.repository = Elasticsearch::Persistence::Repository.new do
      client Elasticsearch::Client.new url: 'http://localhost:9200', log: true
      index :mynotesindex
      type  :note
    end

    config.repository.create_index! force: true

    config.repository.save( { id: 1, done: false , description: 'Buy milk'     } )
    config.repository.save( { id: 2, done: true  , description: 'Learn Rails'  } )
    config.repository.save( { id: 3, done: false , description: 'Do homework'  } )
    config.repository.save( { id: 4, done: true  , description: 'Pack luggage' } )
  end
end

class Note
  attr_reader :attributes

  def initialize(attributes={})
    @attributes = attributes
  end

  def to_hash
    @attributes
  end
end

