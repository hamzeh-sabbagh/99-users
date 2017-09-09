Rails.application.routes.draw do

  namespace 'api' do
    namespace 'v1' do
      post 'import' => 'users#import'
      resources :users
    end
  end

end
