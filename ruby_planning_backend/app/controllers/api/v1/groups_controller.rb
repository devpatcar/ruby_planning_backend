# frozen_string_literal: true

module Api
  module V1
    class GroupsController < ApplicationController
      before_action :set_group, only: %i[show update destroy]

      # GET /groups
      def index
        authorize! :read
        @groups = current_user.groups
        render json: @groups
      end

      # GET /groups/work
      def work
        authorize! :read
        @groups = current_user.groups

        result = []
        @groups = filter_done(@groups) if (params[:filter] == "true")
        @groups.each do |group|
          group.schedulings.each do |s|
            if (s.start_date <= DateTime.now && DateTime.now <= s.end_date && s.check_day)
              result.push(group)
            end
          end
        end

        render json: result
      end

      # GET /groups/1
      def show
        authorize! :read
        render json: @group
      end

      # POST /groups
      def create
        authorize! :create
        @group = Group.new(group_params)
        @group.users.push(current_user)
        if @group.save
          render json: @group, status: :created, location: api_v1_group_url(@group)
        else
          render json: @group.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /groups/1
      def update
        authorize! :update
        if @group.update(group_params)
          render json: @group
        else
          render json: @group.errors, status: :unprocessable_entity
        end
      end

      # DELETE /groups/1
      def destroy
        authorize! :destroy
        @group.destroy
      end

      private

      def set_group
        @group = current_user.groups.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def group_params
        params.require(:group).permit(:name, :description)
      end

      def filter_done(groups)
        result = []
        groups.each do |g|
          count = g.tasks.where(done: false, done: nil).count
          result.push(g) if count > 0
        end
        result
      end
    end
  end
end
