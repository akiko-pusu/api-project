require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    # Userを作成
    before { @users = FactoryBot.create_list(:user, 2) }
    it 'index', autodoc: true do
      get users_path

      # ステータスコードのチェック
      expect(response).to have_http_status(200)

      # JSONの内容のチェック
      json = JSON.parse(response.body)
      expect(json.size).to eq @users.count
      expect(json[0]['id']).to eq @users[0].id
      expect(json[1]['id']).to eq @users[1].id
    end
  end

  describe 'GET /users/:id' do
    # Userを作成
    before { @users = FactoryBot.create_list(:user, 2) }

    subject { get user_path(user_id) }
    context 'GET with valid id' do
      let(:user_id) { User.last.id }
      it 'show', autodoc: true do
        subject

        # ステータスコードのチェック
        expect(response).to have_http_status(200)

        # JSONの内容のチェック
        json = JSON.parse(response.body)
        expect(json['id']).to eq user_id
      end
    end

    context 'GET with invalid id' do
      let(:user_id) { 10 }
      # 例外発生の場合はautodocでエラーになったので、false
      it 'show', autodoc: false do
        expect do
          subject
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    #
    # apipieのバリデーションの動作チェック
    #
    context 'GET with non numeric value' do
      let(:user_id) { 'abc' }
      before { subject }
      it 'return bad request', autodoc: false do
        expect(response).to have_http_status(400)
      end

      it 'has error message' do
        expect(response.body).to be_json_including(
          code: 'invalid_parameter',
          message: "Invalid parameter 'id' value \"#{user_id}\": Must be a number."
        )
      end
    end
  end
end
