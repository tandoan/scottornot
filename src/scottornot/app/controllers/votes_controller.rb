class VotesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_vote
  
  def invalid_vote
    redirect_to '/vote/', notice: 'Invalid Vote'
  end 
  

  #move these cookie methods to the Picture model ?
  def get_prior_votes
    prior_votes = cookies.permanent.signed[:votes]

    if prior_votes.nil?
      prior_votes = []
    end
    return prior_votes
  end

  def add_to_prior_votes(picture_id)

    prior_votes = get_prior_votes
    prior_votes.push picture_id

    if (prior_votes.count > 20)
      prior_votes.shift
    end
    cookies.permanent.signed[:votes] = prior_votes
  end

  def get_prior_picture (prior_vote)
    return prior_picture = Picture.find_by_id(prior_vote)
  end

  def get_prior_percentage (prior_vote)
      prior_count = Vote.where('scott = :is_scott and picture_id= :picture_id', {is_scott: true, picture_id: prior_vote}).count()
      prior_total_votes = Vote.where('picture_id= :picture_id', {picture_id: prior_vote}).count()

      prior_percentage = ((prior_count.to_f/prior_total_votes) * 100)
      return prior_percentage
  end

  def index
    prior_votes = get_prior_votes

    if(prior_votes.last)
      @prior_picture = get_prior_picture prior_votes.last
      @prior_percentage = get_prior_percentage prior_votes.last
    end

    #pick a random picture that isn't in the last 20 from cookies
    id = Picture.where.not(id: prior_votes).pluck(:id).shuffle[0]
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

    respond_to do |format|
      if @vote.save
        add_to_prior_votes p[:picture_id]

        flash[:notice] = "Voted saved!"
        format.html { redirect_to '/vote/'}

        #this is only for json rendering...
        @prior_percentage = get_prior_percentage p[:picture_id]
        prior_votes = get_prior_votes

        id = Picture.where.not(id: prior_votes).pluck(:id).shuffle[0]
        @picture = Picture.find_by_id(id)

        tmp = { :prior_percentage => @prior_percentage, :picture => @picture}
        format.js { render json: tmp, status: :ok }

      else
        flash[:error] = "Error saving vote"
        format.html { redirect_to :action => :index }
        format.json { render json: @vote, status: :unprocessable_entity } 
      end
    end
  end

  private
  def post_params
    params.permit(:commit, :picture_id)
  end
end
