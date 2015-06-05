class Medium < ActiveRecord::Base
  attr_accessible :id,
                  :description,
                  :project_id,
                  :created_at,
                  :updated_at,
                  :uid,
                  :reel_id,
                  :title,
                  :user_id,
                  :interest_id,
                  :photo_file_name,
                  :photo_content_type,
                  :photo_file_size,
                  :photo_updated_at,
                  :body
end
