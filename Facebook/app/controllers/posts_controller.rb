class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  def index
    if(params[:commit]) then
      session.clear
      return redirect_to users_path
    end

    @posts = Post.all
    @username = session[:user][:username]

    if(session[:user][:friends]) then
      session[:user][:friends].each do |friend|
        friend = User.find_by_username("#{friend}")
      end
    end
  end

  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  def search_result
    @profiles = []
    if(params[:search]) then
      @user_search = params[:search].split(' ')
      @matches = []
      @user_search.each do |x|
        @matches << Profile.find_all_by_first_name("#{x.downcase}")
        @matches << Profile.find_all_by_last_name("#{x.downcase}")

        @matched_ids=[]
        @matches.each do |x|
            x.each do |y|
              @matched_ids << y[:id]
            end
        end
        # Store it in session and redirect to display them somewhere
        session[:matches]= @matched_ids
        #return redirect_to '/posts/search_result' 
      end
    end
    if session[:matches] then
      session[:matches].each do |id|
        @profiles << Profile.find("#{id}")
      end
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
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
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
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
end
