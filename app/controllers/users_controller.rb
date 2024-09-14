# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :following, :followers]

  def show
    @user = User.find(params[:id])
    @pagy, @posts = pagy(@user.posts)
  end

  def edit
    @user = User.find(params[:id])
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @pagy, @users = pagy(@user.following)
    render("show_follow")
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @pagy, @users = pagy(@user.followers)
    render("show_follow")
  end
end
