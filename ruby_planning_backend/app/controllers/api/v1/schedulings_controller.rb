# frozen_string_literal: true

module Api
  module V1
    class SchedulingsController < ApplicationController
      before_action :set_group
      before_action :set_scheduling, only: %i[show update destroy]

      # GET /schedulings
      def index
        authorize! :read
        @schedulings = @group.schedulings
        render json: @schedulings
      end

      # GET /schedulings/1
      def show
        authorize! :read
        render json: @scheduling
      end

      # POST /schedulings
      def create
        authorize! :create
        @scheduling = Scheduling.new(scheduling_params)

        if @scheduling.save
          render json: @scheduling, status: :created, location: api_v1_group_schedulings_url(@scheduling)
        else
          render json: @scheduling.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /schedulings/1
      def update
        authorize! :update
        if @scheduling.update(scheduling_params)
          render json: @scheduling
        else
          render json: @scheduling.errors, status: :unprocessable_entity
        end
      end

      # DELETE /schedulings/1
      def destroy
        authorize! :destroy
        @scheduling.destroy
      end

      private

      def set_group
        @group = current_user.groups.find(params[:group_id])
      end

      def set_scheduling
        @scheduling = @group.schedulings.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def scheduling_params
        params.require(:scheduling).permit(:group_id, :name, :description, :start_date, :end_date, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday)
      end
    end
  end
end
