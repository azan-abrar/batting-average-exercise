class Admin::PlayerRecordsController < Admin::BaseController
  before_action :set_player_record, only: %i[destroy]

  def index
    @player_records = PlayerRecord.order(id: :desc)
  end

  def new
    @player_record = PlayerRecord.new
  end

  def create
    file = params[:player_record][:csv_file]
    ActiveRecord::Base.transaction do
      begin
        raise StandardError.new 'File format not supported!' unless file.content_type.include?('text/csv')
        PlayerRecord.parse_csv(file)
        redirect_to admin_player_records_path, notice: 'Player Records have been imported successfully.'
      rescue => ex
        redirect_to new_admin_player_record_path
        flash[:alert] = ex.message
      end
    end
  end

  def destroy
    if @player_record.destroy
      flash[:notice] = 'Player Record has been deleted successfully.'
    else
      flash[:alert]  = 'Error while deleting player record.'
    end
    redirect_to admin_player_records_path
  end

  private

  def set_player_record
    @player_record = PlayerRecord.find_by(id: params[:id])
  end
end
