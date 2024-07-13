class ShortcutsController < ApplicationController
  before_action :set_current_user


  def index
    shortcuts = if params[:env_ids].present?
                  Shortcut.joins(environment: :user)
                          .where(environments: { user_id: @user.id, id: params[:env_ids] })
                          .distinct
                          .order(environment_id: :desc, favorite: :desc, key_binding: :asc)
                else
                  Shortcut.joins(environment: :user)
                          .where(environments: { user_id: @user.id })
                          .distinct
                          .order(environment_id: :desc, favorite: :desc, key_binding: :asc)
                end

    render json: shortcuts, status: 200
  end

  def create
    # todo: if文をネストさせない
    if (environment = Environment.find_by(id: shortcut_info[:environment_id]))
      if @user.id == environment.user_id
        shortcut = environment.shortcuts.new
        shortcut.command = shortcut_info[:command]
        shortcut.key_binding = shortcut_info[:keybinding]
        shortcut.condition = shortcut_info[:when]
        if shortcut.save
          render json: { shortcut: shortcut }, status: 201
        else
          render json: { error: errors.message }, status: 400
        end
      else
        render json: { message: "Faled to create." }, status: 400
      end
    else
      render json: { message: "Environment not found." }, status: 400
    end
  end

  def update
    shortcut = Shortcut.find_by(id: params[:id])

    if @user.id != shortcut.environment.user_id
      render json: { error: "unauthorized",
                     message: "invalid or missing authentication credentials." },
             status: 403
      return
    end

    shortcut.favorite = shortcut_info[:favorite]
    if shortcut.save
      render json: { message: "shortcut infomation updated successfully.",
                     shortcut: shortcut },
             status: 200
    else
      render json: { message: "bad request." }, status: 400
    end

  end

  def destroy
    shortcut = Shortcut.find_by(id: params[:id])
    if @user.id != shortcut.environment.user_id
      render json: { error: "unauthorized",
                     message: "invalid or missing authentication credentials." },
             status: 403
      return
    end

    if shortcut.destroy
      render json: { message: "Shortcut deleted successfully" },
            status: 200
    else
      render json: { error: 'Faile to delete user',
                     message: shortcut.errors.full_messages },
             status: :unprocessable_entity
    end

  end

  private

  def shortcut_info
    params.require(:shortcut_info).permit(:command,
                                          :keybinding,
                                          :when,
                                          :environment_id,
                                          :favorite)
  end

  def env_info
    params.require(:env_info).permit(ids: [])
  end

end
