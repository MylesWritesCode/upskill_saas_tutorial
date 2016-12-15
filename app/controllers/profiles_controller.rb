class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :only_current_user
  
  # GET request to /users/:user_id/profile/new
  def new
    # Render new blank profile detail form.
    @profile = Profile.new
  end
  
  # POST request to /users/:user_id/profile
  def create
    # First grabs the user id from the parameters on the page based on login.
    @user = User.find( params[:user_id] )
    # We're using @user.build_profiles, so that the form is tied to the user that's logged in.
    @profile = @user.build_profile( profile_params )
    if @profile.save
      flash[:success] = "Profile updated!"
      redirect_to user_path(id: params[:user_id] )
    else
      render action: :new
    end
  end
  
  # GET request to /users/:user_id/profile/edit
  def edit
    @user = User.find( params[:user_id] )
    @profile = @user.profile
  end
  
  # PATCH to /users/:user_id/profile
  def update
    # First finds the user_id from db.
    @user = User.find( params[:user_id] )
    # Find user's profile.
    @profile = @user.profile
    # Updated (PATCH) profile attributes then saves.
    if @profile.update_attributes(profile_params)
      flash[:success] = "Profile updated!"
      # Redirect user to their profile page.
      redirect_to user_path (id: params[:user_id] )
    else
      render action : :edit
    end
  end
  
  private
    def profile_params
      params.require(:profile).permit(
        :first_name, 
        :last_name,
        :avatar,
        :job_title, 
        :phone_number, 
        :contact_email, 
        :description
      )
    end
    
    def only_current_user
      @user = User.find( params[:user_id] )
      redirect_to(root_url) unless @user == current_user
    end
end