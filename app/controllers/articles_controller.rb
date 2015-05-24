class ArticlesController < ApplicationController

  def new
    unless user_signed_in?
      redirect_to :root#error
    end
    render 'new.haml'
    @article = Article.new
  end

  def create
    if user_signed_in?
      @article = Article.new(params[:article])
      if @article.save
        redirect_to @article.reel
      else
        render "new"
      end
    else
      flash[:notice] = "You must be signed in to write a story."
      redirect_to :root #TODO Redirect to sign up page
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])  
    if @article.update_attributes( params[:article] )
      flash[:notice] = "Your story has been updated!"
      redirect_to @article.reel
    else
      flash[:notice] = "Woops! Your changes couldn't be saved."
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to current_user
  end
end
