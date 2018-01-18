class SchoolsController < ApplicationController

    include ChessStoreHelpers

    load_and_authorize_resource
    before_action :set_school, only: [:show, :edit,:update, :destroy]

    def index
        @schools = School.active.alphabetical
    end

    def new
        @school = School.new
    end

    def create
        @school = School.create(school_params)
        if @school.save
            redirect_to home_path, notice: "Successfully added #{@school.name}"
        else
            render action: 'new'
        end
    end

    def update
        if @school.update(school_params)
            redirect_to school_path(@school), notice: "Successfully updated #{@school.name}"
        else
            render action: 'edit'
        end
    end

    def show

    end 

    private

    def set_school 
        @school = School.find(params[:id])
    end

    def school_params
        params.require(:school).permit(:name, :street_1, :street_2, :city, :state, :zip, :min_grade, :max_grade)
    end
end
