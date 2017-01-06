class PostsController < ApplicationController

  before_filter :authenticate_user!, :only => [:new, :create, :edit, :destroy]

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
      @post = Post.find(params[:group_id])
    end

    def update
      @post = Post.find(params[:group_id])

      @post.update(post_params)

      redirect_to group_path(@group), notice: "Update Success"
    end

    def destroy
      @group = Group.find(params[:group_id])
      @post.destroy
      flash[:alert] = "Post deleted"
      redirect_to root_path
    end

end

private

def post_params
  params.require(:post).permit(:content)
end

end
