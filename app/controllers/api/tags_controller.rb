class Api::TagsController < ApplicationController

  def index
    render json: ["test", "hello"]
  end
end
