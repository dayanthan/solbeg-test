class BlogsController < ApplicationController
  before_action :authenticate_user!

  def index
    @blogs = Blog.joins(:blog_permissions).where("blogs.user_id =? or blog_permissions.user_id =?",current_user.id,current_user.id).uniq
  end

  def show
    @blog = Blog.find(params[:id])
    @blog_user = @blog.user.name
    @comments = @blog.comments
  end

  def new
    @action = "new"
    @blog = Blog.new
    @users = User.all.where("id != ?", current_user.id)
  end

  def edit
    @action = "edit"
    @blog = Blog.find(params[:id])
    @users = User.all.where("id != ?", current_user.id)
  end

  def create
    @blog = Blog.new(blog_params)
    user_list = params[:blog][:user_list].reject(&:empty?)
    email_list= User.where({id: user_list}).collect(&:email).join(",")
    BlogMailer.blog_invitation(current_user,email_list,@blog.title).deliver_later
    respond_to do |format|
      if @blog.save
        blog_permission(@blog.id, user_list)
        format.html { redirect_to @blog, notice: "Blog was successfully created." }
        format.json { render :show, status: :created, location: @blog }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def blog_permission(id,user_list)
    user_list.each do |user|
      BlogPermission.create(blog_id:id, user_id:user)
    end
  end

  def update
    respond_to do |format|
      if @blog.update(blog_params)
        format.html { redirect_to @blog, notice: "Blog was successfully updated." }
        format.json { render :show, status: :ok, location: @blog }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @blog.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    respond_to do |format|
      format.html { redirect_to blogs_url, notice: "Blog was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog
      @blog = Blog.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def blog_params
      params.require(:blog).permit(:title, :content, :user_id)
    end
end
