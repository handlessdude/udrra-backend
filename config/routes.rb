Rails.application.routes.draw do
  resources :tracks
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      # sign up as a new user
      post '/users', to: 'users#create'
      '''
      INPUT
      HEADERS: <nothing special>
      BODY:
      {
        "login": "login_string",
        "email": "email_string",
        "first_name": "name",
        "second_name": "surname",
        "password": "123456"
      }

      SUCCESSFUL OUTPUT
      {
        "success": true,
        "message": "New user (id=23) is successfully created"
      }
      '''

      # get current user info
      get '/users/:id', to: 'users#show'
      '''
      INPUT
      HEADERS: accessToken
      BODY:
      {
        "userID": 10 (current user`s id)
      }

      SUCCESSFUL OUTPUT
      {
          "success": true,
          "message": "User has been successfully found",
          "data": {
              "login": "login",
              "first_name": "name",
              "second_name": "surname",
              "avatar_url": null,
              "faculty_id": null,
              "created_at": "2021-12-22T19:27:53.542Z",
              "roles": [
                  "user"
              ],
              "id": 23 (:id from request params)
          }
      }
      '''

      # log in
      post '/auth', to: 'auth#create'
      '''
      INPUT
      HEADERS: <nothing special>
      BODY:
      {
          "login": "login",
          "password": 123456
      }

      SUCCESSFUL OUTPUT
      {
          "success": true,
          "message": "Signed in successfully",
          "data": {
              "accessToken": "some access token",
              "expiration_time": "23/12/2021 19:36",
              "user_info": {
                  "login": "login",
                  "first_name": "name",
                  "second_name": "surname",
                  "avatar_url": null,
                  "faculty_id": null,
                  "created_at": "2021-12-22T16:15:37.487Z",
                  "roles": [
                      "user"
                  ],
                  "id": 23 (current user`s id)
              }
          }
      }
      '''

      # log out
      delete '/auth', to: 'auth#destroy' # not used

      # post new file to server
      post '/files', to: 'files#create' # not implemented

      # ====== TRACKS ======

      # ====== SECURE AREA ======

      # create new track
      post '/tracks', to: 'tracks#create'
      '''
      INPUT
      HEADERS: accessToken
      BODY:
      {
          "userID": 10 (current user`s id`),
          "data":
              {
                  "track_name": "track name",
                  "preview_text": "some text",
                  "preview_picture": "some picture",
                  "published": true,
                  "mode": "consistent"
              }
      }

      SUCCESSFUL OUTPUT
      {
          "success": true,
          "message": "New track (id=15) is successfully created"
      }
      '''

      # edit track
      put '/tracks/:id', to: 'tracks#update'
      '''
      INPUT
      HEADERS: accessToken
      BODY:
      {
          "userID": 10 (current user`s id`),
          "data":
              {
                  "track_name": "new track name",
                  "preview_text": "new text",
                  "preview_picture": "new picture",
                  "published": true,
                  "mode": "consistent"
              }
      }

      SUCCESSFUL OUTPUT
      {
          "success": true,
          "message": "Track is successfully updated"
      }
      '''

      # delete track
      delete '/tracks/:id', to: 'tracks#destroy'
      '''
      INPUT
      HEADERS: accessToken
      BODY:
      {
          "userID": 6
      }

      SUCCESSFUL OUTPUT
      {
          "success": true,
          "message": "Track was successfully deleted"
      }
      '''

      # =========================

      # Получение трека по id
      get '/tracks/:id', to: 'tracks#show'
      '''
      INPUT
      HEADERS: accessToken
      BODY:
      {
          "userID": 6
      }

      SUCCESSFUL OUTPUT
      {
          "success": true,
          "message": "Track is successfully shown",
          "data": {
              "id": 1,
              "track_name": "dummy track 1",
              "preview_text": "dummy text",
              "preview_picture": "dummy_picture",
              "published": true,
              "mode": "consistent",
              "created_at": "2021-12-22T16:05:13.895Z",
              "updated_at": "2021-12-22T16:05:13.895Z"
          }
      }
      '''

      # Получение всех треков
      get '/tracks', to: 'tracks#index'
      '''
      INPUT
      HEADERS: accessToken
      BODY:
      {
          "userID": 6,
          "limit": 2,
          "offset": 1
      }

      SUCCESSFUL OUTPUT
      {
          "success": true,
          "message": "Tracks are successfully shown",
          "data": [
              {
                  "id": 2,
                  "track_name": "dummy track 2",
                  "preview_text": "dummy text",
                  "preview_picture": "dummy_picture",
                  "published": true,
                  "mode": "consistent",
                  "created_at": "2021-12-22T16:05:13.904Z",
                  "updated_at": "2021-12-22T16:05:13.904Z"
              },
              {
                  "id": 3,
                  "track_name": "dummy track 3",
                  "preview_text": "dummy text",
                  "preview_picture": "dummy_picture",
                  "published": true,
                  "mode": "consistent",
                  "created_at": "2021-12-22T16:05:13.910Z",
                  "updated_at": "2021-12-22T16:05:13.910Z"
              }
          ]
      }
      '''


      # ====== TRACK ASSIGNS ======

      # ====== SECURE AREA ======

      # assign track to user
      post '/tracks/:track_id/track_assigns', to: 'track_assigns#create'
      '''
      INPUT
      HEADERS: accessToken
      BODY:
      {
          "userID": 6,
          "data": {
              "user_id": 2,
              "status": "some status",
              "finished": false
          }
      }

      SUCCESSFUL OUTPUT
      {
          "success": true,
          "message": "Track is successfully assigned to user"
      }
      '''

      # remove track assign
      delete '/tracks/:track_id/track_assigns', to: 'track_assigns#destroy'
      '''
      INPUT
      HEADERS: accessToken
      BODY:
      {
          "userID": 6,
          "data": {
              "user_id": 2
          }
      }

      SUCCESSFUL OUTPUT
      {
          "success": true,
          "message": "Track assignment was deleted successfully"
      }
      '''

      # =========================

      # get all assigns of some track
      get '/tracks/:track_id/track_assigns', to: 'track_assigns#index'
      '''
      INPUT
      HEADERS: accessToken
      BODY:
      {
          "userID": 6,
          "data": {
              "user_id": 2
          },
          "limit": 2
      }

      SUCCESSFUL OUTPUT
      {
          "success": true,
          "message": "Track assignments are successfully shown",
          "data": [
              {
                  "login": "login1",
                  "first_name": "fname1",
                  "second_name": "sname1",
                  "avatar_url": "ava_url1",
                  "faculty_id": 1,
                  "created_at": "2021-12-22T16:05:14.010Z",
                  "roles": [],
                  "id": 1
              },
              {
                  "login": "login4",
                  "first_name": "fname4",
                  "second_name": "sname4",
                  "avatar_url": "ava_url4",
                  "faculty_id": 4,
                  "created_at": "2021-12-22T16:05:14.021Z",
                  "roles": [],
                  "id": 4
              }
          ]
      }
      '''

      # ====== TRACK DETAILS ======

      # ====== SECURE AREA ======

      post '/tracks/:track_id/details', to: 'track_details#create'
      '''
      INPUT
      HEADERS: accessToken
      BODY:
      {
          "userID": 6,
          "data": {
              "detail_type": "event",
              "finished": true,
              "assigned": true,
              "entity_name": "name",
              "entity_duration": "3 days"
              }
      }
      OR
      {
          "userID": 6,
          "data": {
              "detail_type": "course",
              "finished": true,
              "assigned": true,
              "entity_name": "name",
              "entity_duration": "3 months"
              }
      }
      OR
      {
          "userID": 6,
          "data": {
              "detail_type": "file",
              "finished": true,
              "assigned": true,
              "entity_name": "file name",
              "file_type": "txt",
              "url": "url of file"
              }
      }

      SUCCESSFUL OUTPUT
      {
          "success": true,
          "message": "New track detail (id=15) is successfully created"
      }
      '''

      put '/tracks/details/:track_detail_id', to: 'track_details#update'
      '''
      INPUT
      HEADERS: accessToken
      BODY:
      {
          "userID": 6,
          "data": {
              "detail_type": "file",
              "finished": true,
              "assigned": true,
              "entity_name": "other file name",
              "file_type": "txt",
              "url": "other url of file",
              "track_id": 2
              }
      }

      SUCCESSFUL OUTPUT
      {
          "success": true,
          "message": "Track detail is successfully updated"
      }
      '''

      delete '/tracks/details/:track_detail_id', to: 'track_details#destroy'
      '''
      INPUT
      HEADERS: accessToken
      BODY:
      {
          "userID": 6,
          "data": {
              "track_id": 2
              }
      }

      SUCCESSFUL OUTPUT
      {
          "success": true,
          "message": "Track detail was successfully deleted"
      }
      '''

      # =========================

      # get track detail
      get '/tracks/details/:track_detail_id', to: 'track_details#show'
      '''
      INPUT
      HEADERS: accessToken
      BODY:
      {
          "userID": 6
      }

      SUCCESSFUL OUTPUT
      {
          "success": true,
          "message": "Track detail is successfully shown",
          "data": {
              "detail_type": "event",
              "entity_name": "ochen kaef 3",
              "entity": {
                  "id": 4,
                  "name": "ochen kaef 3",
                  "created_at": "2021-12-22T17:21:39.543Z",
                  "updated_at": "2021-12-22T18:06:43.733Z",
                  "duration": "2 days"
              }
          }
      }
      '''

      # get all track details of some track
      get '/tracks/:track_id/details', to: 'track_details#index'
      '''
      INPUT
      HEADERS: accessToken
      BODY:
      {
          "userID": 6,
          "offset": 4
      }

      SUCCESSFUL OUTPUT
      {
          "success": true,
          "message": "Track details are successfully shown",
          "data": [
              {
                  "id": 10,
                  "detail_type": "event",
                  "entity_name": "ochen kaef",
                  "entity_type": "Event",
                  "entity_id": 3,
                  "created_at": "2021-12-22T17:20:39.850Z",
                  "updated_at": "2021-12-22T17:20:39.850Z"
              },
              {
                  "id": 11,
                  "detail_type": "event",
                  "entity_name": "ochen kaef 3",
                  "entity_type": "Event",
                  "entity_id": 4,
                  "created_at": "2021-12-22T17:21:39.555Z",
                  "updated_at": "2021-12-22T18:06:43.739Z"
              }
          ]
      }
      '''

      # ====== NOTIFICATIONS ======

      # Получение всех уведомлений пользователя
      get '/notifications/:user_id', to: 'notifications#index' # not implemented

      # Получение непрочитанных уведомлений пользователя
      get '/notifications/:user_id/unread', to: 'notifications#index_unread' # not implemented

      # Пометить все уведомления как прочитанные
      put '/notifications/:user_id/read_all', to: 'notifications#update' # not implemented

      # ====== SEARCH ======

      # Поиск пользователей
      get '/search/users', to: 'search#users' # not implemented

      # Поиск ивентов
      get '/search/events', to: 'search#events' # not implemented

      # Поиск курсов
      get '/search/courses', to: 'search#courses' # not implemented

      # Поиск факультетов
      get '/search/faculties', to: 'search#faculties' # not implemented

      # ====== TESTS ======

      # ====== SECURE AREA ======

      # create new test
      post '/tests', to: 'tests#create' # not implemented

      # get all correct answers of test
      get '/tests/:test_id/test_answers', to: 'test_answers#index' # not implemented

      # =========================

      # get test data
      get '/tests/:test_id', to: 'tests#show' # not implemented

      # get all questions of test
      get '/tests/:test_id/test_questions', to: 'test_questions#index' # not implemented

      # send user answers to server
      post '/tests/:test_id/test_user_answers', to: 'test_user_answers#create' # not implemented

      # get user answers
      get '/tests/:test_id/user_user_answers', to: 'test_user_answers#index' # not implemented

      # get user test result
      get '/tests/:test_id/test_result', to: 'test_result#index' # not implemented
    end
  end


end
