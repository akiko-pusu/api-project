class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # リソースについての記述をします
  resource_description do
    formats [:json]          # Suppoeted Formats に該当
    api_versions 'public'    # APIのバージョン
  end

  api :GET, "/users", "List users"
  description 'List users'
  def index
    @users = User.all

    render json: @users
  end

  api :GET, "/users/:id", "Show user"
  description 'Show user'
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.fetch(:user, {}).permit(:name)
    end
end
