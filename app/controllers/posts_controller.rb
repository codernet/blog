class PostsController < ApplicationController
before_filter :authenticate, :except => [:index, :show]  
before_filter :same_user, :only => [:destroy, :edit]
# GET /posts
  # GET /posts.json
  def index
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])

    respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @posts}
        format.xml {render xml: @posts}
        format.atom #index.atom.builder
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

private
def authenticate
  unless User.find_by_id(session[:user_id])
      redirect_to login_url, :notice => "Please log in"
  end
end

def same_user
  if !current_user.nil? 
    @post = user.posts.find_by_id(params[:id])
    if @post.nil?
      flash[:notice] = 'Forbidden.'
      redirect_to root_url
    end 
  else
    redirect_to new_session_path  
  end
end
end
