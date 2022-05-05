class ReportsController < ApplicationController

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

end