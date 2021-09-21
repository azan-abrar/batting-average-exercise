class Admin::TeamsController < Admin::BaseController
  before_action :set_team, except: %i[index create new]

  def index
    @teams = Team.order(id: :desc)
  end

  def new
    @team = Team.new
  end

  def create
    file = params[:team][:csv_file]
    ActiveRecord::Base.transaction do
      begin
        raise StandardError.new 'File format not supported!' unless file.content_type.include?('text/csv')
        Team.parse_csv(file)
        redirect_to admin_teams_path, notice: 'Teams have been imported successfully.'
      rescue => ex
        redirect_to new_admin_team_path
        flash[:alert] = ex.message
      end
    end
  end

  def edit; end

  def update
    if @team.update(team_params)
      redirect_to admin_teams_path, notice: 'Team has been updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    if @team.destroy
      flash[:notice] = 'Team has been deleted successfully.'
    else
      flash[:alert]  = 'Error while deleting team.'
    end
    redirect_to admin_teams_path
  end


  private

  def set_team
    @team = Team.friendly.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:team_id, :name)
  end
end
