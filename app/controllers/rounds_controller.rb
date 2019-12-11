class RoundsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_round, only: [:show, :edit, :update, :destroy]

  # GET /rounds
  # GET /rounds.json
  def index
    @rounds = current_user.rounds
    @handicamp = handicap
  end

  # GET /rounds/1
  # GET /rounds/1.json
  def show
  end

  # GET /rounds/new
  def new
    @round = current_user.rounds.build
  end

  # GET /rounds/1/edit
  def edit
  end

  # POST /rounds
  # POST /rounds.json
  def create
    @round = current_user.rounds.build(round_params)

    respond_to do |format|
      if @round.save
        format.html { redirect_to rounds_url, notice: 'Round was successfully created.' }
        format.json { render :show, status: :created, location: @round }
      else
        format.html { render :new }
        format.json { render json: @round.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rounds/1
  # PATCH/PUT /rounds/1.json
  def update
    respond_to do |format|
      if @round.update(round_params)
        format.html { redirect_to rounds_url, notice: 'Round was successfully updated.' }
        format.json { render :show, status: :ok, location: @round }
      else
        format.html { render :edit }
        format.json { render json: @round.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rounds/1
  # DELETE /rounds/1.json
  def destroy
    @round.destroy
    respond_to do |format|
      format.html { redirect_to rounds_url, notice: 'Round was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_round
      @round = Round.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def round_params
      params.require(:round).permit(:course, :rating, :slope, :score)
    end

    DIFFERENTIALS =   { 
      1 => 1,
      2 => 1,
      3 => 1,  
      4 => 1,
      5 => 1,
      6 => 1,
      7 => 2,
      8 => 2,
      9 => 3,
      10 => 3,
      11 => 4,
      12 => 4,
      13 => 5,
      14 => 5,
      15 => 6,
      16 => 6,
      17 => 7,
      18 => 8,
      19 => 9,
      20 => 10 
    }

    def scores
      @rounds
    end
  
    def handicap
      i = (lowest_differentials.inject(&:+) / lowest_differentials.count) * 0.96
      (i * 10).floor / 10.0
    end
    
    def lowest_differentials  
      index = DIFFERENTIALS[scores.count] || 10
      differentials.sort[0..(index - 1)]
    end
  
    def differentials
      scores.collect {|score|
        (score.score - score.rating) * 113 / score.slope
      }
    end


end
