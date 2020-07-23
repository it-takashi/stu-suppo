class Api::UsersController < ApplicationController

  # 新規登録及び編集時のUser.nameの一意制の確認
  def index
    # 新規ユーザーが名前を登録する際に名前がかぶっていないか検索する。
    unless user_signed_in?
      @user = User.find_by(name: params[:name])
      return @user
    end
    # 編集時に自分の名前を抜かしてが名前がかぶっていないか検索
    unless current_user.name == params[:name]
      @user = User.find_by(name: params[:name])
    end
  end
  
end