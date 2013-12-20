class VotesController < ApplicationController
  def index

    #check if cookies exist, if not, we're good

    previous_votes = cookies.permanent.signed[:votes]

    if previous_votes.nil?
      previous_votes = []
    end

    id = Picture.where.not(id: previous_votes).pluck(:id).shuffle[0]
    @picture = Picture.find_by_id(id)

    #pick a random picture that isn't in the last 20 from cookies

    #display random pic

    #display last voted on

  end

  def vote
    #save vote
    #go back to vote site
  end
end
