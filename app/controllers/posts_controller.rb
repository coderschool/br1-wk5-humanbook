class PostsController < ApplicationController
  before_action :require_login
  
  def create
    @post = current_user.posts.build post_params
    @post.wall_user ||= current_user

    unless @post.save
      flash[:error] = @post.errors.full_messages.to_sentence
    end

    redirect_back fallback_location: root_path
  end

  private

  def post_params
    params.require(:post).permit(:body, :wall_user_id)
  end
end