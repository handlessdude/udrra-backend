# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# окей, гоу сдохнем и напишем хотя бы пару экземпляров

dummy_text = "What is Lorem Ipsum?
Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."

unless Track.any?
  (1..20).each do |ind|
    Track.create!(track_name: "dummy track #{ind}",
                  preview_text: dummy_text,
                  preview_picture: 'dummy_picture',
                  published: true,
                  mode: 'consistent')
  end
end


unless Faculty.any?
  Faculty.create!(faculty: "Самый лучший факультет")
  Faculty.create!(faculty: "Факультет чуть похуже")
  Faculty.create!(faculty: "Прям такой себе факультет")
  Faculty.create!(faculty: "Факультет \"ни рыба, ни мясо\"")
end

unless User.any?
  (1..4).each do |ind|
    User.create!(login: "login#{ind}",
                encrypted_password:"pwd#{ind}",
                first_name: "fname#{ind}",
                second_name: "sname#{ind}",
                avatar_url: "ava_url#{ind}",
                faculty_id: ind)
  end
end

unless Notification.any?
  (1..2).each do |ind|
    Notification.create!(text: "notif ##{ind}",
                         created_at: DateTime.now)
  end
end

unless NotificationsUser.any?
  NotificationsUser.create!(looked: false,
                            notification_id: Notification.first.id,
                            user_id: User.first.id)
  NotificationsUser.create!(looked: true,
                            notification_id: Notification.last.id,
                            user_id: User.first.id)
  NotificationsUser.create!(looked: true,
                            notification_id: Notification.first.id,
                            user_id: User.last.id)
end

unless TracksUser.any?
  TracksUser.create!(track_id: Track.first.id,
                     user_id: User.first.id,
                     status: "norm",
                     finished: false)
  TracksUser.create!(track_id: Track.last.id,
                     user_id: User.first.id,
                     status: "ne norm",
                     finished: true)
  TracksUser.create!(track_id: Track.first.id,
                     user_id: User.last.id,
                     status: "nu takoe",
                     finished: false)
end

unless PostedFile.any?
  (1..2).each do |ind|
    PostedFile.create!(file_type: "type#{ind}",
                 url: "url#{ind}")
  end
end

unless Course.any?
  Course.create!(name: "Самый лучший курс",
                 duration: DateTime.now)
  Course.create!(name: "Умеренный курс",
                 duration: DateTime.now)
end

unless Event.any?
  Event.create!(name: "Хорошее имя")
  Event.create!(name: "Тоже хорошее имя")
end

unless Detail.any?
  Detail.create!(detail_type: "file",
                 entity_name: "name1",
                 entity_duration: "1 month",
                 entity: PostedFile.first)
  Detail.create!(detail_type: "course",
                 entity_name: "name2",
                 entity_duration: "2 month",
                 entity: Course.first)
  Detail.create!(detail_type: "event",
                 entity_name: "name3",
                 entity_duration: "3 month",
                 entity: Event.first)
end

unless Test.any?
  (1..2).each do |ind|
    Test.create!(name: "test_name#{ind}",
                 description: "desc #{ind}",
                 instruction: "instruction #{ind}",
                 duration: "duration #{ind}",
                 img: "img #{ind}")
  end
end

unless TestQuestion.any?
  (1..4).each do |ind|
    TestQuestion.create!(test_id: 1,
                         question_type: "type #{ind}",
                         name: "name #{ind}",
                         description: "desc #{ind}",
                         img: "img #{ind}")
  end
  (1..4).each do |ind|
    TestQuestion.create!(test_id: 2,
                         question_type: "type #{4+ind}",
                         name: "name #{4+ind}",
                         description: "desc #{4+ind}",
                         img: "img #{4+ind}")
  end
end

unless TestQuestionVariant.any?
  (1..8).each do |ind|
    TestQuestionVariant.create!(title: "вариант 1 для вопроса #{ind}")
    TestQuestionVariant.create!(title: "вариант 2 для вопроса #{ind}")
  end
end

unless TestQuestionAnswer.any?
  (1..8).each do |ind|
    TestQuestionAnswer.create!(test_question_id: TestQuestion.find(ind).id,
                               test_question_variant_id: (ind-1)*2 + 1,
                               is_correct: true)
    TestQuestionAnswer.create!(test_question_id: TestQuestion.find(ind).id,
                               test_question_variant_id: (ind-1)*2 + 2,
                               is_correct: false)
  end
end

#TODO сделать Test_User_Answers



