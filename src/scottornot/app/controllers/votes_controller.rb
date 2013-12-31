class VotesController < ApplicationController
  
  #move these cookie methods to the Picture model ?
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
    if prior_vote
      @prior_picture = Picture.find_by_id(prior_vote)

      @prior_count = Vote.where('scott = :is_scott and picture_id= :picture_id', {is_scott: true, picture_id: prior_vote}).count()
      @prior_total_votes = Vote.where('picture_id= :picture_id', {picture_id: prior_vote}).count()

      @prior_percentage = ((@prior_count.to_f/@prior_total_votes) * 100)
    end

    #pick a random picture that isn't in the last 20 from cookies
    id = Picture.where.not(id: previous_votes).pluck(:id).shuffle[0]
    @picture = Picture.find_by_id(id)

  end

  def vote
    p = post_params()

    #save vote
    is_scott = false
    if "Scott!" == p[:commit]
      is_scott = true
    elsif "Not!" == p[:commit]
      is_scott = false
    end

    @vote = Vote.new({:picture_id=>p[:picture_id], :scott=>is_scott})

    if @vote.save
      add_to_previous_votes p[:picture_id]
      flash[:notice] = "Voted saved!"
      redirect_to '/vote/'
    else
      flash[:error] = "Error saving vote"
      redirect_to :action => :index
    end
  end

  private
  def post_params
    params.permit(:commit, :picture_id)
  end
end
