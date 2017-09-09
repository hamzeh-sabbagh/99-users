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

        file_data = params[:uploaded_file]
        csv_text = File.read(file_data)
        csv = CSV.parse(csv_text, :headers => true)

        csv.uniq.each do |elem|
          puts "#{elem}\t#{csv.count(elem)}"
        end

        render json: {status: 'SUCCESS', message:'Updated user', data:csv_text},status: :ok

      end

      private
      def users_params
        params.permit(:first_name, :last_name)
      end

    end
  end
end