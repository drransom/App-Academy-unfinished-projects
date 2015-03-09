class ContactsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    if @user
      render json: (@user.contacts.all + @user.shared_contacts.all)
    else
      render json: @user.errors.full_messages,
                   error: :user_not_found
    end
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      render json: @contact
    else
      render json: @contact.errors.full_messages,
                   status: :error_creating_contact
    end
  end

  def show
    @contact = Contact.find(params[:id])
    if @contact
      render json: @contact
    else
      render json: @contact.errors.full_messages, status: :contact_not_found
    end
  end

  def update
    @contact = Contact.find(params[:id])
    if @contact
      @contact.update(contact_params)
      render json: @contact
    else
      render json: @contact.errors.full_messages,
                   status: :error_updating_contact
    end
  end

  def destroy
    @contact = Contact.find(params[:id])
    if @contact
      Contact.destroy(@contact.id)
      render json: @contact
    else
      render json: @contact.errors.full_messages,
                   status: :error_updating_contact
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :user_id)
  end
end
