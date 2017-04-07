Rails.application.routes.draw do
  root 'static_pages#home'
  get 'bionomial_fit' => "static_pages#bionomial_fit" 
end
