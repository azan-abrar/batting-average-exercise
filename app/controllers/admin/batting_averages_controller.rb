class Admin::BattingAveragesController < Admin::BaseController
  before_action :set_batting_average, only: %i[destroy]

  def index
    @batting_averages = BattingAverage.order(id: :desc)
  end

  def new
    @batting_average = BattingAverage.new
  end

  def create
    file = params[:batting_average][:csv_file]
    ActiveRecord::Base.transaction do
      begin
        raise StandardError.new 'File format not supported!' unless file.content_type.include?('text/csv')
        BattingAverage.parse_csv(file)
        redirect_to admin_batting_averages_path, notice: 'Battings have been imported successfully.'
      rescue => ex
        redirect_to new_admin_batting_average_path
        flash[:alert] = ex.message
      end
    end
  end

  def destroy
    if @batting_average.destroy
      flash[:notice] = 'Batting has been deleted successfully.'
    else
      flash[:alert]  = 'Error while deleting batting average.'
    end
    redirect_to admin_batting_averages_path
  end

  private

  def set_batting_average
    @batting_average = BattingAverage.find_by(id: params[:id])
  end
end
