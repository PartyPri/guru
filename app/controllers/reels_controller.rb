class ReelsController < ApplicationController
  before_filter :set_interests, only: [:new, :edit]
  before_filter :credit_invitation, only: [:show]

  NOT_FOUND_NOTICE = "Reel not found"

  impressionist :actions=>[:show]


  def index
    interest_id = params[:interest_id]

    if interest_id && interest = Interest.find(interest_id)
      reels = interest.reels
    else
      reels = Reel
    end

    tagged_reels = reels.tagged_with(params[:tag])

    if params[:user_id]
      tagged_reels = tagged_reels.by_user_id(params[:user_id].to_i)
    end

    # render json: tagged_reels, serializer: ReelSerializer

    render :json => tagged_reels, :include => { :user => {:only => [:first_name, :last_name]}, images: {methods: :photo}, videos: {}, stories: {}, impressions: {} }
  end

  def show
    @reel = Reel.includes(:user).find_by_id(params[:id])
    return redirect_with_notice(NOT_FOUND_NOTICE) if @reel.nil?

    @images = @reel.images
    @videos = @reel.videos
    @user = @reel.user
    @media = @reel.media.order("position")
    @featured_video = @videos.where(featured_medium: true)
    @all_user = User.all
    @credits = Credit.includes(:receiver).by_reel(params[:id])
    @milestone_icons = {
      "eureka" => "fa-lightbulb-o",
      "mission_accomplished" => "fa-flag-checkered",
      "challenge" => "fa-exclamation-triangle",
      "victory" => "fa-trophy",
      "done" => "fa-check-square",
      "experiment" => "fa-flask",
      "lesson_learned" => "fa-bookmark"
    }
  end

  def new
    return redirect_with_notice(AUTH_NOTICE) unless user_signed_in?
    @reel = Reel.new
  end

  def create
    if user_signed_in?
      @reel = Reel.new(params[:reel])
      @reel.user = current_user
      if @reel.save
        redirect_to @reel
      else
        render "new"
      end
    else
      flash[:notice] = "You must be signed in to create a reel."
      redirect_to :root #TODO Redirect to sign up page
    end
  end

  def edit
    @reel = Reel.find(params[:id])
    @media = @reel.media.order("position")

    unless current_user && current_user == @reel.user
      redirect_to :root
      flash[:notice] = "You do not have permission to view that page."
    end
  end

  def update
    @reel = Reel.find(params[:id])
    if @reel.update_attributes( params[:reel] )
      flash[:notice] = "Your reel's been updated!"
      redirect_to @reel
    else
      flash[:notice] = "Woops! Your changes couldn't be saved."
      render 'edit'
    end
  end

  def destroy
    @reel = Reel.find(params[:id])
    @reel.destroy
    redirect_to current_user
  end

  def sort
    params[:medium].each_with_index do |id, index|
      Medium.update_all({position: index+1}, {id: id})
    end
    render nothing: true
  end

  private

  def credit_invitation
    return if params[:credit_invitation].nil?
    @pending_credit = Credit.includes(:owner)
                    .pending
                    .where(id: params[:credit_invitation])
                    .first
  end

  def set_interests
    @interests = Interest.all
  end
end
