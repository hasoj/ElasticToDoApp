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

    case session[:what_to_show]
      when 'show_completed'
        @allitems = repository.search('done:true').to_a.map(&:to_hash)
      when 'show_active'
        @allitems = repository.search('done:false').to_a.map(&:to_hash)
      else
        @allitems = repository.search('*').to_a.map(&:to_hash)
    end

  end

  def withitem_do
    repository = Elasticsearch::Persistence::Repository.new do
      client Elasticsearch::Client.new url: 'http://localhost:9200', log: true
      index :mynotesindex
      type  :note
    end

    item = repository.find(params[:id].to_i).to_hash
    item['done'] = !item['done']
    repository.save(item)

    puts
    puts
    puts
    p item
    puts
    puts
    puts

    item = repository.find(params[:id].to_i).to_hash
    
    puts
    puts
    puts
    p item
    puts
    puts
    puts

    redirect_to '/todo'
  end

  def buttonsatbottom
    repository = Elasticsearch::Persistence::Repository.new do
      client Elasticsearch::Client.new url: 'http://localhost:9200', log: true
      index :mynotesindex
      type  :note
    end
    
    session['what_to_show'] = 'show_all'
    if params.has_key?('buttontoshowcompleted')
      session['what_to_show'] = 'show_completed'
    end
    if params.has_key?('buttontoshowactive')
      session['what_to_show'] = 'show_active'
    end

    redirect_to '/todo'
  end

end

