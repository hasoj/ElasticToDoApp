Rails.application.routes.draw do
  get '/todo' => 'to_do_app#todo'

  post '/withitem/:id' => 'to_do_app#withitem_do'
  post '/buttonsatbottom' => 'to_do_app#buttonsatbottom'
end
