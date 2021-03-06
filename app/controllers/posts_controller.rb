class PostsController < ApplicationController

def index
  # GET /posts
  # GET /posts.json
    params.keys.each do |key|
      session[:user][:friends].each do |friend|
        if key == friend[0] then
          @new_friend = key
        end
      end
      if(@new_friend) then
        @tmp = User.find_by_username(@new_friend)
        session[:user].add_friend(@tmp[:username])
        @tmp.add_friend(session[:user][:username])
        return redirect_to posts_path
      end
    end
    
    if(params[:commit]== "Logout") then
      session.clear
      return redirect_to users_path
    end

    # Display your own posts
    if(session[:user][:id])then
      @id = session[:user][:id]
      @user = User.find(@id)
      @profile = Profile.find_by_username(@user.username)
      @first_name = @profile[:first_name].capitalize
      @profile_id = @profile[:user_id]
    end

    @friends = []
    @requests = []
    @request_profiles = []
    @username = session[:user][:username]
    if(session[:user][:friends]) then
      session[:user][:friends].each do |friend|
        if friend[1] == "friend" and friend[0] != session[:user][:username] then
          @tmp1 = User.find_by_username(friend[0])
          @friends << [friend[0],@tmp1.id]
        elsif friend[1] == "requesting" then
          @requests << friend[0]
        end
      end
    end

    if(@requests != []) then
    @requests.each do |request|
      new_request = Profile.find_by_username(request)
      @request_profiles << new_request
    end
    end

    # Display most recent posts
    @posts = []
    i = 0
    @friends.each do |friend|
      @tmp = User.find_by_username("#{friend[0]}")
      @tmp_profile = Profile.find(@tmp.id)
      case @tmp.post_count
      when nil
        
      when 0
        
      when 1
        ((@tmp.post_count - 1)..(@tmp.post_count - 1)).each do |item|
          @posts << @tmp.posts[item]
        end
      when 2
        ((@tmp.post_count - 2)..(@tmp.post_count - 1)).each do |item|
          @posts << @tmp.posts[item]
        end
      when 3
        ((@tmp.post_count - 3)..(@tmp.post_count - 1)).each do |item|
          @posts << @tmp.posts[item]
        end
      else
        ((@tmp.post_count - 4)..(@tmp.post_count - 1)).each do |item|
          @posts << @tmp.posts[item]
        end
      end
      @friends[i][0] = @tmp_profile.first_name.capitalize + " " + @tmp_profile.last_name.capitalize
      i = i+1
    end

    session[:user] = User.find_by_username(session[:user][:username])

    if(session[:user].post_count) then
      case session[:user].post_count
      when 0
        
      when 1
        ((session[:user].post_count - 1)..(session[:user].post_count - 1)).each do |item|
          @posts << session[:user].posts[item]
        end
      when 2
        ((session[:user].post_count - 2)..(session[:user].post_count - 1)).each do |item|
          @posts << session[:user].posts[item]
        end
      when 3
        ((session[:user].post_count - 3)..(session[:user].post_count - 1)).each do |item|
          @posts << session[:user].posts[item]
        end
      else
        ((session[:user].post_count - 4)..(session[:user].post_count - 1)).each do |item|
          @posts << session[:user].posts[item]
        end
      end
    end


    if(@posts.size > 1)
    @posts = @posts.sort_by {|post| post.created_at}
    @posts = @posts.reverse
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
    if(params[:search]) then
      @profiles = []
      @user_search = params[:search].split(' ')
      @user_search.each do |x|
        @profiles += Profile.find_all_by_first_name("#{x.downcase}")
        @profiles += Profile.find_all_by_last_name("#{x.downcase}")
      end
      @friends = []
      @enemies = []

      if(session[:user].friend_count > 1) then
        tmp = []
        session[:user][:friends].each do |f|
          tmp << f[0]
        end

        @profiles.each do |b|
          if tmp.include?(b.username) then
            @friends << b
          else
            @enemies << b
          end
        end
    
      else
        @profiles.each do |b|
          @enemies << b
        end
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
    if(params[:message]) then
      @user = User.find(session[:user][:id])
      @user.add_post(params[:message])
      redirect_to posts_path, :method => :get
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
