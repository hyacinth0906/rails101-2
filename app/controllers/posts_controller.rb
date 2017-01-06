class PostsController < ApplicationController

  before_filter :authenticate_user!, :only => [:new, :create, :edit, :destroy]
  before_action :find_post_and_check_permission, only: [:edit, :update, :destroy]

  def new
    @group = Group.find(params[:group_id])
    @post = Post.new
  end

  def create
    @group = Group.find(params[:group_id])
    @post = Post.new(post_params)
    @post.group = @group
    @post.user = current_user

    if @post.save
      redirect_to group_path(@group)
    else
      render :new
    end

    def edit
    end

    def destroy
      @post.destroy
      flash[:alert] = "Post deleted"
      redirect_to root_path
    end

end

private

def post_params
  params.require(:post).permit(:content)
end

def find_post_and_check_permission
  @post = Post.find(params[:group_id])

  if current_user != @post.user
    redirect_to root_path, alert: "You have no permission."
  end
end

end
