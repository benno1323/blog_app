class CommentsController < ApplicationController
  load_and_authorize_resource

  def create
    byebug
  	load_post
  	build_comment

  	if @comment.save
  		redirect_to @post, notice: "El comentario fue creado con exito!"
  	else
  		redirect_to @post, notice: "No se pudo crear el comentario!"
  	end
  end

  private

  def load_post
  	@post = Post.find(params[:post_id])
  end

  def build_comment
  	@comment = @post.comments.build(comment_params)
    @comment.user = current_user
  end

  def comment_params
  	params.require(:comment).permit(:content)
  end
end