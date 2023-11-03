class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_team, only: %i[ show edit update destroy ]


  # GET /teams or /teams.json
  def index
    #show only teams that the user is in or is the owner of it
    @teams = Team.where(user_id: current_user.id).or(Team.where(id: current_user.teams.pluck(:id)))
  end

  # GET /teams/1 or /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams or /teams.json
  def create
    @team = Team.new(team_params)
    @team.code = generate_random_code
    @team.user_id = current_user.id

    respond_to do |format|
      if @team.save
        format.html { redirect_to team_url(@team), notice: "Team was successfully created." }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1 or /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to team_url(@team), notice: "Team was successfully updated." }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def join
    if request.post?
      @team = Team.find_by(code: params[:code])
      if @team
        if @team.users.include?(current_user)
          flash.now[:alert] = 'You are already in the team.'
          render :join, status: :unprocessable_entity
          return
        else
          @team.users << current_user
          redirect_to @team, notice: 'You have joined the team successfully!'
        end
      else
        flash.now[:alert] = 'Team with the provided code does not exist.'
        render :join, status: :unprocessable_entity
      end
    end
  end

  def leave
    @team = Team.find(params[:id])
    if @team.users.include?(current_user)
      @team.users.delete(current_user)
      redirect_to teams_path, notice: 'You have left the team successfully!'
    else
      redirect_to teams_path, alert: 'You are not in the team.'
    end
  end


  # DELETE /teams/1 or /teams/1.json
  def destroy
    @team.destroy

    respond_to do |format|
      format.html { redirect_to teams_url, notice: "Team was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def team_params
      params.fetch(:team, {}).permit(:name)
    end

    def generate_random_code
      code = rand(100000..999999)
      if Team.find_by(code: code)
        generate_random_code
      else
        code
      end
    end


end
