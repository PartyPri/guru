class CommentsController < ApplicationController
  def create
    @comment_hash = params[:comment]
    @obj = @comment_hash[:commentable_type].constantize.find(@comment_hash[:commentable_id])
    # Not implemented: check to see whether the user has permission to create a comment on this object
    @comment = Comment.build_from(@obj, current_user.id, @comment_hash[:body])
    if @comment.save
      if @comment_hash[:p_comment]
        @parent = Comment.find(@comment_hash[:p_comment])
        if @parent.root
          @root = @parent.root
        else
          @root = @parent
        end
        @div = "#replies-#{@root.id}"
        render :json => { :comments => render_to_string( :partial => "comments/reply_comment", :locals => { :comment => @comment }), :division => @div }, :layout => false, :status => :created
        @comment.move_to_child_of(@parent)
      else
        render :json => { :comments => render_to_string( :partial => "comments/comment", :locals => { :comment => @comment }) }, :layout => false, :status => :created
      end
    else
      render :js => "alert('error saving comment');"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @div = "#replies-#{@comment.id}"
    if @comment.destroy
      render :json => @comment, :division => @div, :status => :ok
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
