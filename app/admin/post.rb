ActiveAdmin.register Post do
  form do |f|
    f.inputs "Details" do
      f.input :user
      f.input :caption
      f.input :video_url
    end
    f.actions
  end
end
