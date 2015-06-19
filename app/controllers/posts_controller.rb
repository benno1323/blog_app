class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  # before_action :set_post, only: [:show, :edit, :update, :destroy]
  # load_and_authorize_resource except: :upvote
  load_and_authorize_resource

  # GET /posts
  # GET /posts.json
  def index
    # @posts = Post.all No son necesarios debido al load_and_authorize_resources
    @q = params[:q]
    if params[:q]
      @posts = Post.where("content ilike ?","%#{@q}%") # Busqueda con título exacto
    else
      @posts = Post.all
    end
    @posts = @posts.page params[:page]
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @last_comments = @post.comments.last(5)
    @comment = @post.comments.build
  end

  # GET /posts/new
  def new
    # @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create

    # @post = Post.new(post_params)
    # @post.user = current_user
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
        format.js
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upvote
    @vote = Vote.find_or_initialize_by user: current_user, post: @post

    return destroy_and_redirect if @vote.persisted?
    save_and_redirect
  end

  private

    def destroy_and_redirect
      @vote.destroy
      redirect_to @post, notice: "Tu voto ha sido anulado!"
    end

    def save_and_redirect
      if @vote.save
        redirect_to @post, notice: "Tu voto se creo con éxito!"
      else
        redirect_to @post, notice: @vote.errors.full_messages.join(", ")
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    # def set_post
    #   @post = Post.find(params[:id])
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :photo, :photo_cache)
    end
end
