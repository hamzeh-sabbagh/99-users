module Api
  module V1
    class UsersController < ApplicationController
      def index
        users = User.order('created_at DESC');
        render json: {status: 'SUCCESS', message:'Loaded Users', data:users},status: :ok
      end

      def show
        users = User.find(params[:id])
        render json: {status: 'SUCCESS', message:'Loaded Users', data:users},status: :ok
       end

       def create
        users = User.new(users_params)

        if users.save
          render json: {status: 'SUCCESS', message:'Saved user', data:users},status: :ok
        else
          render json: {status: 'ERROR', message:'User not saved', data:users.errors},status: :unprocessable_entity
        end
      end

      def destroy
        users = User.find(params[:id])
        users.destroy
        render json: {status: 'SUCCESS', message:'Deleted user', data:users},status: :ok
      end

      def update
        users = User.find(params[:id])
        if users.update_attributes(user_params)
          render json: {status: 'SUCCESS', message:'Updated user', data:users},status: :ok
        else
          render json: {status: 'ERROR', message:'User not updated', data:users.errors},status: :unprocessable_entity
        end
      end

      def import
        require 'csv'

        # file_data = params[:uploaded_file]
        csv = CSV.parse(params.keys[0], :headers => true)

        first_names_count = Hash.new(0)
        csv.each do |elem|
          first_names_count[elem[1]] += 1
        end

        first_names_count.each do |name, count|
          if count == 1
            first_names_count.delete(name)
          end
        end

        render json: {status: 'SUCCESS', message:'Uploaded file', data:first_names_count},status: :ok

      end

      private
      def users_params
        params.permit(:first_name, :last_name)
      end

    end
  end
end