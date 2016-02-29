class Api::TagsController < ApplicationController
  def index
    # tags = ActsAsTaggableOn::Tag.where("name like ?", "%#{params[:term]}%")
    # render json: tags.map(&:name)
    tags = Interest.all.map{|interest| {:id => interest.id, :interest => interest.name, :tags => interest.tag_list}}
    render json: tags
  end
end
