class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    
    if(session[:user]) then
      return redirect_to posts_path
    end
    if(params[:signup_username] && params[:signup_password] && params[:first_name] && params[:last_name])
      if(!params[:signup_username].empty? && !params[:signup_password].empty? && !params[:first_name].empty? && !params[:last_name].empty?) then
        temp = User.find_all_by_username(params[:signup_username]) 
        temp.each do |user|
          if(user[:username] == params[:signup_username]) then
            flash[:notice] = "That username is already taken."
            return redirect_to users_path
          end
        end
      @user = User.new(:username=>params[:signup_username], :password => params[:signup_password], :friends =>[ params[:signup_username]])
      @profile = Profile.new(:first_name=>params[:first_name].downcase, :last_name=>params[:last_name].downcase)
      @user.profile = @profile
      @user.save!
      return redirect_to users_path
      end
    end
    if(params[:username])
      temp = User.find_by_username(params[:username])
      p temp
      if(temp) then
        if(temp[:password] == params[:password]) then
          session[:user] = temp
          return redirect_to posts_path
        else 
          return redirect_to users_path
      end
          return redirect_to users_path
    end
    end

  end


  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
