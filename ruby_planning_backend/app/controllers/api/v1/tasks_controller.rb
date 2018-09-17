# frozen_string_literal: true

module Api
  module V1
    class TasksController < ApplicationController
      before_action :set_group
      before_action :set_task, only: %i[show update destroy]

      # GET /tasks
      def index
        authorize! :read
        @tasks = @group.tasks
        render json: @tasks
      end

      # GET /tasks/1
      def show
        authorize! :read
        render json: @task
      end

      def tasks_done
        authorize! :read
        @tasks = @group.tasks
        render json: get_done_status(@tasks)
      end

      # POST /tasks
      def create
        authorize! :create
        @task = Task.new(task_params)

        if @task.save
          render json: @task, status: :created, location: api_v1_group_tasks_url(@task)
        else
          render json: @task.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /tasks/1
      def update
        authorize! :update
        if @task.update(task_params)
          render json: @task
        else
          render json: @task.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /tasks/1/submit
      def submit
        authorize! :update
        if @task.update(done: true, result: task_params.result)
          render json: @task
        else
          render json: @task.errors, status: :unprocessable_entity
        end
      end

      # DELETE /tasks/1
      def destroy
        authorize! :destroy
        @task.destroy
      end

      private

      def set_group
        @group = current_user.groups.find(params[:group_id])
      end

      def set_task
        @task = @group.tasks.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def task_params
        params.require(:task).permit(:name, :description, :done, :input_type, :result, :group_id)
      end

      def get_done_status(tasks)
        done = 0
        undone = 0

        tasks.each do |task|
          if task.done
            done = done +1
          else
            undone = undone +1
          end
        end
        return {done: done, undone: undone}
      end
    end
  end
end
