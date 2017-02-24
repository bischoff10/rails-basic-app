class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :only_current_user
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts
    # @posts = Post.where("user_id = ?", @user.id)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end

  # GET /posts/new
  def new
    @user = User.find(params[:user_id])
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    # @post = Post.new(post_params)
    

    # respond_to do |format|
    #   if @post.save
    #     format.html { redirect_to @post, notice: 'Post was successfully created.' }
    #     format.json { render :show, status: :created, location: @post }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @post.errors, status: :unprocessable_entity }
    #   end
    # end
    
    @user = User.find(params[:user_id])
    @post = @user.posts.build(post_params)
    if @post.save
      flash[:success] = "Post created!"
      redirect_to user_post_path(user_id: @user.id, id: @post.id)
    else
      flash[:warning] = "Something went wrong"
      render action: :new
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    # respond_to do |format|
    #   if @post.update(post_params)
    #     format.html { redirect_to @post, notice: 'Post was successfully updated.' }
    #     format.json { render :show, status: :ok, location: @post }
    #   else
    #     format.html { render :edit }
    #     format.json { render json: @post.errors, status: :unprocessable_entity }
    #   end
    # end
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    # if @profile.update_attributes(profile_params)
    # @post = @user.posts
    if @post.update(post_params)
      flash[:success] = "Post Updated"
      redirect_to user_post_path(user_id: @user.id, id: @post.id)
    else
      flash[:error] = "Something went wrong."
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    # @post.destroy
    # respond_to do |format|
    #   format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
    
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    
    if @post.delete
      flash[:success] = "Post deleted."
      redirect_to user_posts_path(user_id: @user.id)
    else
      flash[:error] = "Something went wrong."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      # @post = Post.find(params[:user_id])
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:body)
    end
    
    def only_current_user
      @user = User.find( params[:user_id] )
      redirect_to(root_url) unless @user == current_user
    end
end
