# frozen_string_literal: true

require 'rails_helper'
RSpec.describe 'AdminUsers' do
  let!(:admin_user) { create(:user, :admin) }
  let!(:non_admin_user) { create(:user, :noadmin) }

  describe 'GET /admin/users' do
    subject { get admin_users_path }

    context 'ログインしている場合' do
      context 'ユーザが管理者の場合' do
        context 'クエリパラメータにpageがない場合' do
          xit 'ユーザ取得の関数Api::Userのget_listに引数(limit: 10, offset:0)を設定して呼ぶ' do
            # TODO: specの内容を作成する
          end

          xit 'ユーザの表示数は10' do
            # TODO: specの内容を作成する
          end
        end

        context 'クエリパラメータにpageがある場合' do
          context 'pageの値が0の場合' do
            xit 'ユーザ取得の関数Api::Userのget_listに引数(limit: 10, offset:0)を設定して呼ぶ' do
              # TODO: specの内容を作成する
            end

            xit 'ユーザの表示数は10' do
              # TODO: specの内容を作成する
            end
          end

          context 'pageの値が1の場合' do
            xit 'ユーザ取得の関数Api::Userのget_listに引数(limit: 10, offset:0)を設定して呼ぶ' do
              # TODO: specの内容を作成する
            end

            xit 'ユーザの表示数は10' do
              # TODO: specの内容を作成する
            end
          end

          context 'pageの値が2の場合' do
            xit 'ユーザ取得の関数Api::Userのget_listに引数(limit: 10, offset:10)を設定して呼ぶ' do
              # TODO: specの内容を作成する
            end

            xit 'ユーザの表示数は10' do
              # TODO: specの内容を作成する
            end
          end
        end
      end

      context 'ユーザが管理者ではない場合' do
        before { log_in_as(non_admin_user) }

        it 'ログインページにリダイレクトしてトーストメッセージを表示する' do
          expect(subject).to redirect_to login_url
          expect(response).to have_http_status :see_other
          expect(flash[:danger]).not_to be_nil
        end
      end
    end

    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトしてトーストメッセージを表示する' do
        expect(subject).to redirect_to login_url
        expect(response).to have_http_status :see_other
        expect(flash[:danger]).not_to be_nil
      end
    end
  end
end
