class Api::TagsController < ApplicationController

  def index
    render json: ActsAsTaggableOn::Tag.all.map{|t| t.name}
  end
end
