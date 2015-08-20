class CommentsController < ApplicationController
  def create
    @comment_hash = params[:comment]
    @obj = @comment_hash[:commentable_type].constantize.find(@comment_hash[:commentable_id])
    # Not implemented: check to see whether the user has permission to create a comment on this object
    @comment = Comment.build_from(@obj, current_user.id, @comment_hash[:body])
    if @comment.save
      render :json => { :comments => render_to_string( :partial => "comments/comment", :locals => { :comment => @comment }) }, :layout => false, :status => :created
    else
      render :js => "alert('error saving comment');"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      render :json => @comment, :status => :ok
    else
      render :js => "alert('error deleting comment');"
    end
  end

  def reply
    @comment = Comment.find(params[:id])
    @obj = Medium.find(@comment.commentable_id)
    @div_id = "comment-#{@comment.id}"
    respond_to do |format|
      format.js
    end
  end
end
