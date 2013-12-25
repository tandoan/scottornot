class VotesController < ApplicationController
  def index

    #check if cookies exist, if not, we're good

    previous_votes = cookies.permanent.signed[:votes]

    if previous_votes.nil?
      previous_votes = []
    end

    @votes = previous_votes.inspect

    id = Picture.where.not(id: previous_votes).pluck(:id).shuffle[0]
    @picture = Picture.find_by_id(id)

    #pick a random picture that isn't in the last 20 from cookies

    #display random pic

    #display last voted on

  end

  def vote
    p = post_params()

    #save vote
    is_scott = false
    if "scott" == p[:scott]
      is_scott = true
    end

    @vote = Vote.new({:picture_id=>p[:picture_id], :scott=>is_scott})
    @vote.save


    #deal with cookies
    previous_votes = cookies.permanent.signed[:votes]

    if previous_votes.nil?
      previous_votes = []
    end

    previous_votes.push p[:picture_id]

    if (previous_votes.count > 20)
      previous_votes.shift
    end
    cookies.permanent.signed[:votes] = previous_votes


    #go back to vote site
    #redirect_to 'votes#index'
    index


  end

  private
  def post_params
    params.permit(:scott, :picture_id)
  end
end
