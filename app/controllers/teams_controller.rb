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
    #show all users email that are in the team
    @users = @team.users
    #show the owner of the team
    @owner = User.find(@team.user_id)
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
      #check if the user is the owner of the team
      if @team.user_id != current_user.id
        redirect_to teams_path, alert: 'Nisi lastnik/ca te ekipe.'
      end
  end

  # POST /teams or /teams.json
  def create
    @team = Team.new(team_params)
    @team.code = generate_random_code
    @team.user_id = current_user.id

    respond_to do |format|
      if @team.save
        format.html { redirect_to team_url(@team), notice: "Ekipa je bila uspešno ustvarjena!" }
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
      #check if the user is the owner of the team
      if @team.user_id != current_user.id
        redirect_to teams_path, alert: 'Nisi lastnik/ca te ekipe.'
      else
        if @team.update(team_params)
          format.html { redirect_to team_url(@team), notice: "Ekipa je bila uspešno urejena!" }
          format.json { render :show, status: :ok, location: @team }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @team.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def join
    if request.post?
      @team = Team.find_by(code: params[:code])
      if @team
        if @team.users.count < 4
          if @team.user_id == current_user.id || @team.users.include?(current_user)
            flash[:alert] = 'V to ekipo si že včlanjen/a.'
            render :join, status: :unprocessable_entity
          else
            @team.users << current_user
            redirect_to @team, notice: 'Uspešno si se včlanil/a v ekipo.'
          end
        else
          flash[:alert] = 'Ekipo je že polna.'
          render :join, status: :unprocessable_entity
        end
      else
        flash.now[:alert] = "Ekipa s to kodo ne obstaja."
        render :join, status: :unprocessable_entity
      end
    end
  end


  def leave
    @team = Team.find(params[:id])
    if @team.users.include?(current_user)
      @team.users.delete(current_user)
      redirect_to teams_path, notice: 'Uspešno si zapustil/a ekipo.'
    else
      redirect_to teams_path, alert: 'Nisi v tej ekipi.'
    end
  end


  # DELETE /teams/1 or /teams/1.json
  def destroy
    @team.destroy

    respond_to do |format|
      format.html { redirect_to teams_url, notice: "Ekipa je bila uspešno izbrisana!" }
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
      params.fetch(:team, {}).permit(:name, game_ids: [])
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
