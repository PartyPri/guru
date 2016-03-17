# encoding: UTF-8
# This file is auto-generated from the current content of the database. Instead
# of editing this file, please use the migrations feature of Seed Migration to
# incrementally modify your database, and then regenerate this seed file.
#
# If you need to create the database on another system, you should be using
# db:seed, not running all the migrations from scratch. The latter is a flawed
# and unsustainable approach (the more migrations you'll amass, the slower
# it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Base.transaction do

  User.create({"avatar_content_type"=>"image/png", "avatar_file_name"=>"8940009.png", "avatar_file_size"=>13165, "avatar_updated_at"=>"2016-03-01T18:54:31Z", "bio"=>"\r\n Long Ago... \r\n Tell us a bit about yourself here. Like where did you come from? \r\n \r\n Here & Now... \r\n What inspires you? What are you working on? What's most exciting to you? \r\n \r\n To Infinity & Beyond! \r\n What's in store for the future?", "categories"=>nil, "claim_email"=>nil, "claim_token"=>nil, "claim_user"=>nil, "cover_photo_content_type"=>"image/jpeg", "cover_photo_file_name"=>"Death_to_Stock_Photography_NYC_Skyline_7.jpg", "cover_photo_file_size"=>15042556, "cover_photo_updated_at"=>"2016-03-01T19:19:21Z", "created_at"=>"2016-02-26T10:08:53Z", "current_sign_in_at"=>"2016-03-17T14:08:18Z", "current_sign_in_ip"=>"127.0.0.1", "description"=>"jfdasjfaksfjkakj adfkjajsdfkaks", "email"=>"rawtekniques@gmail.com", "encrypted_password"=>"$2a$10$y30Flxwiaj7i1tZX7L1ca.eZQPv9.XiXHwmHe28I8o7TPwNNzNRUW", "expires_at"=>"2016-03-17T15:08:17Z", "featured_artist"=>true, "first_name"=>"Lee", "id"=>1, "last_name"=>"Chesley @bgirlmislee", "last_sign_in_at"=>"2016-03-15T18:08:08Z", "last_sign_in_ip"=>"127.0.0.1", "location"=>"california, usa", "provider"=>"google_oauth2", "remember_created_at"=>nil, "reset_password_sent_at"=>nil, "reset_password_token"=>nil, "sign_in_count"=>9, "token"=>"ya29.qAL5JUUC5g5JYRNwn93Y3w03SDmQVAkY7HiK1m3tFon27mRWaZ0wZjyJBglV9LN2TA", "uid"=>"106469362669522609251", "updated_at"=>"2016-03-17T14:08:18Z"}, :without_protection => true)

  User.create({"avatar_content_type"=>nil, "avatar_file_name"=>nil, "avatar_file_size"=>nil, "avatar_updated_at"=>nil, "bio"=>nil, "categories"=>nil, "claim_email"=>nil, "claim_token"=>nil, "claim_user"=>nil, "cover_photo_content_type"=>nil, "cover_photo_file_name"=>nil, "cover_photo_file_size"=>nil, "cover_photo_updated_at"=>nil, "created_at"=>"2016-03-01T19:40:20Z", "current_sign_in_at"=>"2016-03-16T23:11:04Z", "current_sign_in_ip"=>"127.0.0.1", "description"=>nil, "email"=>"bboymadtek@gmail.com", "encrypted_password"=>"$2a$10$x7OV1b7V9EVXHwaQbBGkq.HNgcu4x2dWUZtomkLqQe.XXowecXwUG", "expires_at"=>"2016-03-17T00:11:03Z", "featured_artist"=>nil, "first_name"=>"Mad", "id"=>2, "last_name"=>"Tek", "last_sign_in_at"=>"2016-03-10T07:42:02Z", "last_sign_in_ip"=>"127.0.0.1", "location"=>nil, "provider"=>"google_oauth2", "remember_created_at"=>nil, "reset_password_sent_at"=>nil, "reset_password_token"=>nil, "sign_in_count"=>4, "token"=>"ya29.pwJ0S-maoEptT5mmNIxXyWy68WGwil4UQHm-D_TRzm_V_0B92ZKDf5NvG0sNoxrdQA", "uid"=>"111734429301260506911", "updated_at"=>"2016-03-16T23:11:04Z"}, :without_protection => true)

  User.create({"avatar_content_type"=>nil, "avatar_file_name"=>nil, "avatar_file_size"=>nil, "avatar_updated_at"=>nil, "bio"=>nil, "categories"=>nil, "claim_email"=>nil, "claim_token"=>nil, "claim_user"=>nil, "cover_photo_content_type"=>nil, "cover_photo_file_name"=>nil, "cover_photo_file_size"=>nil, "cover_photo_updated_at"=>nil, "created_at"=>"2016-03-16T23:11:50Z", "current_sign_in_at"=>"2016-03-16T23:14:38Z", "current_sign_in_ip"=>"127.0.0.1", "description"=>nil, "email"=>"bboytek@gmail.com", "encrypted_password"=>"$2a$10$DhIZRuM53qU7P4gjJVR5muoSXu4Q8Wk3j03lnJWXJByRL6iXSY4A6", "expires_at"=>"2016-03-17T00:14:37Z", "featured_artist"=>nil, "first_name"=>"Teck", "id"=>3, "last_name"=>"L", "last_sign_in_at"=>"2016-03-16T23:11:50Z", "last_sign_in_ip"=>"127.0.0.1", "location"=>nil, "provider"=>"google_oauth2", "remember_created_at"=>nil, "reset_password_sent_at"=>nil, "reset_password_token"=>nil, "sign_in_count"=>2, "token"=>"ya29.pwJr8Vyb-dQqSEUgCxpW1kPCwFMoc1a4Mv-kPj3odAwmZeC2adE52bv7y8tJkK4Q8g", "uid"=>"110831006162001050523", "updated_at"=>"2016-03-16T23:14:38Z"}, :without_protection => true)
  ActiveRecord::Base.connection.reset_pk_sequence!('users')

  Interest.create({"cover_photo_content_type"=>nil, "cover_photo_file_name"=>nil, "cover_photo_file_size"=>nil, "cover_photo_updated_at"=>nil, "created_at"=>"2016-02-26T18:37:57Z", "description"=>nil, "history"=>nil, "id"=>1, "name"=>"Art & Film", "quote_author"=>nil, "updated_at"=>"2016-02-29T21:16:03Z"}, :without_protection => true)

  Interest.create({"cover_photo_content_type"=>nil, "cover_photo_file_name"=>nil, "cover_photo_file_size"=>nil, "cover_photo_updated_at"=>nil, "created_at"=>"2016-02-26T18:38:09Z", "description"=>nil, "history"=>nil, "id"=>2, "name"=>"Video and such", "quote_author"=>nil, "updated_at"=>"2016-02-29T21:18:20Z"}, :without_protection => true)

  Interest.create({"cover_photo_content_type"=>nil, "cover_photo_file_name"=>nil, "cover_photo_file_size"=>nil, "cover_photo_updated_at"=>nil, "created_at"=>"2016-02-26T18:38:26Z", "description"=>nil, "history"=>nil, "id"=>3, "name"=>"Fashion & Beauty", "quote_author"=>nil, "updated_at"=>"2016-02-29T21:17:56Z"}, :without_protection => true)
  ActiveRecord::Base.connection.reset_pk_sequence!('interests')
  ActiveRecord::Base.connection.reset_pk_sequence!('user_interests')
end

SeedMigration::Migrator.bootstrap(20160317054303)
