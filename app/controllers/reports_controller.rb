class ReportsController < ApplicationController
    before_action :set_pickup, only: [:destroy]
    def new 
        @report = Report.new 
    end 

    def create 
        #Create a report site issue record
        report_params = params.require(:report).permit(:subject, :description) 
        @report = Report.new(report_params)
        @report.update(user_id: current_user.id)
        if @report.save 
            redirect_to help_walkers_path, notice: 'Report was created.' 
        else
            render :report_new 
        end 
    end

    def destroy
        @report.destroy
        redirect_to view_reports_admins_path, notice: 'Report was successfully deleted.'
    end
    
    private
        # Use callbacks to share common setup or constraints between actions.
        def set_pickup
            @report = Report.find(params[:id])
        end
end