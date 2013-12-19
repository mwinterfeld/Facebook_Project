class ProfilesController < ApplicationController
  # GET /profiles
  # GET /profiles.json
  def index
    @current_user = User.find(session[:user].id)
    @current_user.friends.each do |friend|
      params.keys.each do |param|
        if(param == friend[0])
          @current_friend = User.find_by_username(friend[0])
          @current_user.remove_friend(friend[0])
          @current_friend.remove_friend(session[:user].username)
          session[:user] = User.find(session[:user].id)
          return redirect_to posts_path
        end
      end
    end
    
    @profiles = []
    session[:user].friends.each do |friend|
      if(friend[1] == "friend")
        @profiles << Profile.find_by_username(friend[0])
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @profiles }
    end
  end

  # GET /profiles/1.json
  def public
   if(params[:add]) then
      current_user = User.find(session[:user][:id])
      new_friend = User.find(params[:format])

      new_friend.requesting(current_user.username)
      current_user.pending(new_friend.username)
      session[:user] = current_user
      return redirect_to posts_path
    end
    @current_user = User.find(params[:format])
    @profile = @current_user.profile
    @current_user = []  
  end

  def private
    @current_user = User.find(params[:format])
    @id = @current_user.id
    @profile = Profile.find_by_username(@current_user.username) 
  end

  def friends
    @profile = session[:user][:friends]
  end
  # GET /profiles/new
  # GET /profiles/new.json
  def new

  end

  # GET /profiles/1/edit
  def edit
    if session[:user][:id] then
      @current_user = User.find(session[:user][:id])
      @id = @current_user.id
      @profile = @current_user.profile
    else
        redirect_to posts_path 
    end
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(params[:profile])

    respond_to do |format|
      if @profile.save
        format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
        format.json { render json: @profile, status: :created, location: @profile }
      else
        format.html { render action: "new" }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /profiles/1
  # PUT /profiles/1.json
  def update
    @profile = Profile.find(params[:id])

    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        format.html { redirect_to private_profiles_path(session[:user].id), notice: 'Profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile = Profile.find(params[:id])
    @profile.destroy

    respond_to do |format|
      format.html { redirect_to profiles_url }
      format.json { head :no_content }
    end
  end
end