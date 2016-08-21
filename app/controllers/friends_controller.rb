class FriendsController < ApplicationController
  before_action :require_signed_in!, only: [:create]
  respond_to :html, :js
  # t.integer  "summoner_id",      null: false
  # t.string   "summoner_name",    null: false
  # t.integer  "summoner_icon_id"
  # t.integer  "revision_date"
  # t.integer  "summoner_level"
  # t.integer  "user_id",          null: false
  # t.datetime "created_at",       null: false
  # t.datetime "updated_at",       null: false

  def index
    if current_user
      @friends = []
      current_user.friends.each do |friend|
        @friends.push(friend)
      end
    else
      @friends = []
    end
    render "_index"
  end

  def create
    @friend = Friend.new(friend_params)
    @friend.user_id = current_user.id
    @friend.revision_date = parseUTC(@friend.revision_date)
    if @friend.save
      @friends = current_user.friends
      render :partial => '/friends/index'
    else
      @friends = current_user.friends
      render :partial => '/friends/index'
      # render :json => @friend.errors.full_messages, status: 404
    end
  end


  # def update
  #   # @post = Post.find(params[:id])
  #   # if @post.update_attributes(post_params)
  #   #   render "show"
  #   # else
  #   #   render :json => @post.errors
  #   # end
  #   @friend = Friend.find(params[:summoner_name])
  #   @friend.update(params[:revision_date])
  #   @friend.addTo(Friend)
  # end

  # def show
  #   # @post = Post.find(params[:id])
  #   # @comments = @post.comments.sort_by(&:created_at) #need to sort by newests, and upvotes this isnt working
  #   # render "show"
  # end

  def destroy
    @friend = Friend.find(params[:id])
    @friend.destroy!
    @friends = current_user.friends
    render :partial => '/friends/index'
  end

  private

    def friend_params
      params.require(:friend).permit(:summoner_id, :summoner_name, :summoner_icon_id, :revision_date, :summoner_level, :tier, :division, :user_id)
    end

    def parseUTC(revision_date)
      sec = (revision_date.to_f/1000).to_s
      return Date.strptime(sec, '%s')
    end

    def search
      if friend.params
        targetFriend = Friend.Where(params.id).Equals(id)
      end
    end
end
