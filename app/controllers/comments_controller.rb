class CommentsController < ApplicationController
  load_and_authorize_resource

  def create
  	load_post
  	build_comment

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post, notice: "El comentario fue creado con exito!" }
        format.js
      else
        format.html { render 'posts/show', notice: "No se pudo crear el comentario!" }
        format.js
      end
    end
  end

  private

  def load_post
  	@post = Post.find(params[:post_id])
    @last_comments = @post.comments.last(5)
  end

  def build_comment
  	@comment = @post.comments.build(comment_params)
    @comment.user = current_user
  end

  def comment_params
  	params.require(:comment).permit(:content, :photo, :photo_cache)
  end
end