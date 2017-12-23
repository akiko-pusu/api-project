require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #show' do
    # Userを作成
    before { @users = FactoryBot.create_list(:user, 2) }
    subject { get :show, params: { id: user_id } }

    context 'GET with valid id' do
      let(:user_id) { User.last.id }
      it 'show' do
        subject
        expect(response.body).to be_json_including(id: user_id)
      end
    end

    #
    # apipieのバリデーションの動作チェック
    #
    context 'GET with non numeric value' do
      let(:user_id) { 'abc' }
      before { subject }
      # Status Code Check
      it 'return bad request' do
        expect(response).to have_http_status(400)
      end

      # 例外発生とrescueの結果エラーメッセージが返る
      it 'has error message' do
        expect(response.body).to be_json_including(
          code: 'invalid_parameter',
          message: "Invalid parameter 'id' value \"#{user_id}\": Must be a number."
        )
      end

      # 例外発生はApipieのバリデーションエラーが発生したためであることをチェック
      it 'rescued Apipie::ParamInvalid' do
        bypass_rescue
        expect do
          subject
        end.to raise_error(Apipie::ParamInvalid)
      end
    end
  end
end
