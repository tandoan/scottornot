class VotesController < ApplicationController
  
  def get_previous_votes
    previous_votes = cookies.permanent.signed[:votes]

    if previous_votes.nil?
      previous_votes = []
    end
    return previous_votes
  end

  def add_to_previous_votes(picture_id)

    previous_votes = get_previous_votes
    previous_votes.push picture_id

    if (previous_votes.count > 20)
      previous_votes.shift
    end
    cookies.permanent.signed[:votes] = previous_votes
  end


  def index
    previous_votes = get_previous_votes

    prior_vote = previous_votes.last
    @prior_picture = Picture.find_by_id(prior_vote)

    @prior_count = Vote.where('scott = :is_scott and picture_id= :picture_id', {is_scott: true, picture_id: prior_vote}).count()
    @total_prior_votes = Vote.where('picture_id= :picture_id', {picture_id: prior_vote}).count()

    @percentage_prior = ((@prior_count.to_f/@total_prior_votes) * 100)

    #pick a random picture that isn't in the last 20 from cookies
    id = Picture.where.not(id: previous_votes).pluck(:id).shuffle[0]
    @picture = Picture.find_by_id(id)

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


    add_to_previous_votes p[:picture_id]
    #go back to vote site
    index


  end

  private
  def post_params
    params.permit(:scott, :picture_id)
  end
end
