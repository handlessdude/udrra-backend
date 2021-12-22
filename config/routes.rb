Rails.application.routes.draw do
  resources :tracks
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      # sign up as a new user
      post '/users', to: 'users#create' #+

      # get current user info
      get '/users/:id', to: 'users#show' #+

      # log in
      post '/auth', to: 'auth#create' #+

      # log out
      delete '/auth', to: 'auth#destroy' #not used

      # post new file to server
      post '/files', to: 'files#create'

      # ====== TRACKS ======

      # ====== SECURE AREA ======

      # create new track
      post '/tracks', to: 'tracks#create' #+

      # edit track
      put '/tracks/:id', to: 'tracks#update' #+

      # delete track
      delete '/tracks/:id', to: 'tracks#destroy' #+

      # =========================

      # Получение трека по id
      get '/tracks/:id', to: 'tracks#show' #+

      # Получение всех треков
      get '/tracks', to: 'tracks#index' #+


      # ====== TRACK ASSIGNS ======

      # ====== SECURE AREA ======

      # assign track to user
      post '/tracks/:track_id/track_assigns', to: 'track_assigns#create' #+

      # remove track assign
      delete '/tracks/:track_id/track_assigns', to: 'track_assigns#destroy' #+

      # =========================

      # get all assigns of some track
      get '/tracks/:track_id/track_assigns', to: 'track_assigns#index' #+

      # ====== TRACK DETAILS ======

      # ====== SECURE AREA ======

      post '/tracks/:track_id/details', to: 'track_details#create'

      put '/tracks/details/:track_detail_id', to: 'track_details#update'

      delete '/tracks/details/:track_detail_id', to: 'track_details#destroy'

      # =========================

      # get track detail
      get '/tracks/details/:track_detail_id', to: 'track_details#show' #+

      # get all track details of some track
      get '/tracks/:track_id/details', to: 'track_details#index' #+

      # ====== NOTIFICATIONS ======

      # Получение всех уведомлений пользователя
      get '/notifications/:user_id', to: 'notifications#index' #+

      # Получение непрочитанных уведомлений пользователя
      get '/notifications/:user_id/unread', to: 'notifications#index_unread' #+

      # Пометить все уведомления как прочитанные
      put '/notifications/:user_id/read_all', to: 'notifications#update' #+

      # ====== SEARCH ======

      # Поиск пользователей
      get '/search/users', to: 'search#users' #+-

      # Поиск ивентов
      get '/search/events', to: 'search#events'

      # Поиск курсов
      get '/search/courses', to: 'search#courses'

      # Поиск факультетов
      get '/search/faculties', to: 'search#faculties'

      # ====== TESTS ======

      # ====== SECURE AREA ======

      # create new test
      post '/tests', to: 'tests#create'

      # get all correct answers of test
      get '/tests/:test_id/test_answers', to: 'test_answers#index'

      # =========================

      # get test data
      get '/tests/:test_id', to: 'tests#show'

      # get all questions of test
      get '/tests/:test_id/test_questions', to: 'test_questions#index'

      # send user answers to server
      post '/tests/:test_id/test_user_answers', to: 'test_user_answers#create'

      # get user answers
      get '/tests/:test_id/user_user_answers', to: 'test_user_answers#index'

      # get user test result
      get '/tests/:test_id/test_result', to: 'test_result#index'
    end
  end


end
