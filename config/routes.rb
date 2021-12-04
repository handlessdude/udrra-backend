Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #
  root 'home#index'

  # sign up as a new user
  post '/users', to: 'users#create'

  # get current user info
  get '/users', to: 'users#show'

  # log in
  post '/auth', to: 'auth#create'

  # log out
  delete '/auth', to: 'auth#destroy'

  # post new file to server
  post '/files', to: 'files#create'

  # ====== TRACKS ======

  # ====== SECURE AREA ======

  # create new track
  post '/tracks', to: 'tracks#create'

  # edit track
  put '/tracks/:track_id', to: 'tracks#update'

  # delete track
  delete 'tracks/:id', to: 'tracks#destroy'

  # =========================

  # Получение трека по id
  get '/tracks/:id', to: 'tracks#show'

  # Получение всех треков
  get '/tracks', to: 'tracks#index'


  # ====== TRACK ASSIGNS ======

  # ====== SECURE AREA ======

  # assign track to user
  post '/tracks/:track_id/track_assigns', to: 'track_assigns#create'

  # remove track assign
  delete '/tracks/:track_id/track_assigns', to: 'track_assigns#destroy'

  # =========================

  # get all assigns of some track
  get '/tracks/:track_id/track_assigns', to: 'track_assigns#index'

  # ====== TRACK DETAILS ======

  # ====== SECURE AREA ======

  post '/tracks/:track_id/details', to: 'track_details#create'

  put '/tracks/details/:track_detail_id', to: 'track_details#update'

  delete '/tracks/details/:track_detail_id', to: 'track_details#destroy'

  # =========================

  # get track detail
  get '/tracks/details/:track_detail_id', to: 'track_details#show'

  # get all track details of some track
  get '/tracks/:track_id/details', to: 'track_details#index'

  # ====== NOTIFICATIONS ======

  # Получение всех уведомлений пользователя
  get '/notifications/:user_id', to: 'notifications#index'

  # Получение непрочитанных уведомлений пользователя
  get '/notifications/:user_id/unread', to: 'notifications#index'

  # Пометить все уведомления как прочитанные
  put '/notifications/:user_id/read_all', to: 'notifications#update'

  # ====== SEARCH ======

  # Поиск пользователей
  get '/search/users', to: 'search#index'

  # Поиск ивентов
  get '/search/events', to: 'search#index'

  # Поиск курсов
  get '/search/courses', to: 'search#index'

  # Поиск факультетов
  get '/search/faculties', to: 'search#index'

  # ====== TESTS ======

  # ====== SECURE AREA ======

  # create new test
  post '/tests', to: 'tests#create'

  # get correct answers
  get '/tests/:test_id/answers', to: 'answers#index'

  # =========================

  # get test info
  get '/tests/:test_id', to: 'tests#show'

  # get test questions
  get '/tests/:test_id/test_questions', to: 'questions#index'

  # send user answers to server
  post '/tests/:test_id/test_answers', to: 'answers#create'

  # get user answers
  get '/tests/:test_id/user_answers', to: 'answers#index'

  # get user test result
  get '/tests/:test_id/test_result', to: 'result#index'

end
