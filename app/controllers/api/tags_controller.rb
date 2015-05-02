class Api::TagsController < ApplicationController

  def index
    tags = ActsAsTaggableOn::Tag.where("name like ?", "%#{params[:term]}%")
    render json: tags.map(&:name)
  end
end
