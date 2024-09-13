# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @pagy, @posts = pagy(@user.posts)
  end

  def edit
    @user = User.find(params[:id])
  end
end
