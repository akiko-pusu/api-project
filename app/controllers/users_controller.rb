class UsersController < ApplicationController
  before_action :set_user, only: %i[show update destroy]

  # リソースについての記述をします
  resource_description do
    short 'ユーザ情報を扱うエンドポイント'
    path '/users'
    formats [:json]          # Suppoeted Formats に該当
    api_versions 'public'    # APIのバージョン

    description <<-EOS
      ## エンドポイントの説明

       ここにエンドポイントの詳細な説明を記載できます。

          Headline: <%= headline %>
          First name: <%= person.first_name %>

       このAPIを使うときは、このヘッダをつけてね、とか。

       apipieでのドキュメントの記載方法は、apipie-railsのspecの下にある
       spec用のspec/dummyを見るとよくわかります。
    EOS

    # APIリクエストにヘッダが必要な場合は、ここに記載します
    header :CommonHeader, 'ヘッダの詳細を記載します', required: true
    header 'X-SAMPLE-HEADER', 'ヘッダの詳細を記載します', required: true
  end

  api :GET, '/users', 'ユーザ一覧を返します'
  # エラーの指定はこのような形で
  error code: 401, desc: 'Unauthorized'
  error code: 404, desc: 'Not Found'

  # 利用例は example に記載
  example <<-EDOC
  $ curl http://localhost:3000/users/
        [
          {
            "id": 1,
            "created_at": "2017-12-21T13:06:56.966Z",
            "updated_at": "2017-12-21T13:06:56.966Z",
            "name": "サンプルユーザ1"
          },
          {
            "id": 2,
            "created_at": "2017-12-21T13:06:56.966Z",
            "updated_at": "2017-12-21T13:06:56.966Z",
            "name": "サンプルユーザ2"
          }
        ]
  EDOC
  def index
    @users = User.all

    render json: @users
  end

  api :GET, '/users/:id', '指定のIDのユーザ情報を返します'
  description '指定のIDのユーザ情報を返します'
  formats ['json']
  error 401, 'Unauthorized'
  error code: 404, description: 'Not Found'

  # パラメータ情報に加えて、簡単なバリデーションもapipie側で実施してくれます
  param :id, :number, desc: 'user id', required: true

  example <<-EDOC
  $ curl http://localhost:3000/users/

        {
          "id": 2,
          "created_at": "2017-12-21T13:06:56.966Z",
          "updated_at": "2017-12-21T13:06:56.966Z",
          "name": "サンプルユーザ2"
        }
  EDOC
  # まだこのapiのドキュメントを表示させたくない場合は show false を指定
  # show false
  def show
    render json: @user
  end

  # POST /users
  api :POST, '/users', 'ユーザの追加'
  param :user, Hash do
    param :name, String, desc: 'ユーザ名を指定します', allow_blank: false, required: true
  end
  example <<-EDOC
  $ curl -X POST -F "user[name]=サンプルユーザ3" http://localhost:3000/users
      {
        "id": 3,
        "created_at": "2017-12-21T13:26:55.937Z",
        "updated_at": "2017-12-21T13:26:55.937Z",
        "name": "サンプルユーザ3"
      }
  EDOC

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
