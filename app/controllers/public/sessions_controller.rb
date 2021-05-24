# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :reject_member, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def after_sign_in_path_for(resource)
    posts_path
  end

  def guest_sign_in
    member = Member.guest
    sign_in member
    redirect_to member_path(member), notice: 'ゲストユーザーとしてログインしました。'
  end

  protected
  # メンバーのis_deletedがtrueだった場合ログインを弾く
  def reject_member
    @member = Member.find_by(email: params[:member][:email].downcase)
    if @member
      if (@member.valid_password?(params[:member][:password]) && (@member.active_for_authentication? == false))
        render "new"
      end
    end
  end



  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
