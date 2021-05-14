class Admin::MembersController < ApplicationController
  def index
    if params[:search]
      @members = Member.search(params[:search])
      # binding.pry
    else
      @members = Member.all
    end
  end
end
