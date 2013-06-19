class UsersController < ApplicationController
	before_filter :authenticate_user!
	before_filter :parse_params, :only => [ :search ]
	before_filter :parse_country_params, :only => [ :update ]
	before_filter { flash[:alert] = nil }

  # GET /users
  # GET /users.json
  def index
    @users = User.all
	
		flash[:alert] =  @users.blank? ? "Sorry, There are no members yet!" : nil
	
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1/show
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end
  
  # GET /users/search
  def search
    @users = User.search_result(params[:q])
    flash[:alert] = "No result found for this filter!" if @users.blank?
		render "index"
  end

#  # GET /users/new
#  # GET /users/new.json
#  def new
#    @user = User.new

#    respond_to do |format|
#      format.html # new.html.erb
#      format.json { render json: @user }
#    end
#  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

#  # POST /users
#  # POST /users.json
#  def create
#    @user = User.new(params[:user])

#    respond_to do |format|
#      if @user.save
#        format.html { redirect_to @user, notice: 'User was successfully created.' }
#        format.json { render json: @user, status: :created, location: @user }
#      else
#        format.html { render action: "new" }
#        format.json { render json: @user.errors, status: :unprocessable_entity }
#      end
#    end
#  end

  # PUT /users/1/update
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

#  # DELETE /users/1
#  # DELETE /users/1.json
#  def destroy
#    @user = User.find(params[:id])
#    @user.destroy

#    respond_to do |format|
#      format.html { redirect_to users_url }
#      format.json { head :no_content }
#    end
#  end

  private
  def parse_params
    params["q"] = JSON.parse(params["q"]).first rescue nil
  end

  def parse_country_params
    params["user"]["location_country"] = JSON.parse(params["user"]["location_country"]).first rescue nil
  end
end
