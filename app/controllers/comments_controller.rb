class CommentsController < ApplicationController
  before_action :authenticate_user!

  def edit
    @blog = Blog.find(params[:blog_id])
    @comment = Comment.find(params[:id])
  end

  def create
    @blog = Blog.find(params[:blog_id])
    @comment = Comment.create(body:params[:body],blog_id:params[:blog_id],user_id:current_user.id)
    @comments = @blog.comments
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @blog = Blog.find(params[:blog_id])
    @comment = Comment.find(params[:id])
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @blog, notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @blog = Blog.find(params[:blog_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @blog, notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:body, :blog, :user_id)
    end
end
