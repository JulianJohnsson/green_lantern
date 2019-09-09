class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def new
    @comment = Comment.new
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to edit_transaction_path(@comment.my_transaction), notice: 'Merci ! Votre message a bien été envoyé, nous allons vérifier le calcul de cette dépense' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:transaction_id, :description, :author)
  end

end
