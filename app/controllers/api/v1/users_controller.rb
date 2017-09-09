module Api
  module V1
    class UsersController < ApplicationController
      def index
        users = User.order('created_at DESC');
        render json: {status: 'SUCCESS', message:'Loaded Users', data:users},status: :ok
      end

      def show
        users = Users.find(params[:id])
        render json: {status: 'SUCCESS', message:'Loaded Users', data:users},status: :ok
       end

       def create
        users = Users.new(users_params)

        if users.save
          render json: {status: 'SUCCESS', message:'Saved user', data:users},status: :ok
        else
          render json: {status: 'ERROR', message:'User not saved', data:users.errors},status: :unprocessable_entity
        end
      end

      def destroy
        users = Users.find(params[:id])
        user.destroy
        render json: {status: 'SUCCESS', message:'Deleted user', data:users},status: :ok
      end

      def update
        users = Users.find(params[:id])
        if user.update_attributes(user_params)
          render json: {status: 'SUCCESS', message:'Updated user', data:user},status: :ok
        else
          render json: {status: 'ERROR', message:'User not updated', data:user.errors},status: :unprocessable_entity
        end
      end

      def import
        require 'csv'    

        file_data = params[:uploaded_file]
        csv_text = File.read(file_data)
        csv = CSV.parse(csv_text, :headers => true)
        csv.each do |row|
          Moulding.create!(row.to_hash)
        end
      end

      private
      def users_params
        params.permit(:first_name, :last_name)
      end

    end
  end
end