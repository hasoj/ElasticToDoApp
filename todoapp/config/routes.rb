Rails.application.routes.draw do
  get '/todo' => 'to_do_app#todo'
end
