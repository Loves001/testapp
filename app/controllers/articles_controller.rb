class ArticlesController < ApplicationController
   before_action :set_article, only: [:show, :edit, :update, :destroy]
   before_action :require_user, except: [:index, :show]
   before_action :require_same_user, only: [:edit, :update, :destroy]
   before_action :authenticate_user!
 
   # GET /articles or /articles.json
   def index
     @articles = Article.all
  end
 
   # GET /articles/1 or /articles/1.json
   def show
   end
 
   # GET /articles/new
   def new
     @article = Article.new
   end
 
   # GET /articles/1/edit
   def edit
     @articles= Article.find(params[:id])
     respond_to do |format|
      format.html 
      format.js 
     end
   end
 
   # POST /articles or /articles.json
   def create
     @article = Article.new(article_params)
     @article.user = current_user
     if @article.save
       PostMailer.with(user: current_user, article:@article).post_created.deliver_later # we create a action to deliver the mail.
        flash[:notice] = "Article was succesfully created"
        respond_to do |format|
           # format.html {redirect_to article_path(@article)}
           format.js
        end
     else
        render 'new'
     end
   end
 
 
   # PATCH/PUT /articles/1 or /articles/1.json
   def update
     # respond_to do |format|
     if @article.update (article_params)
       respond_to do |format|
         format.html { redirect_to article_url(@article), notice: "Article was successfully updated." }
         format.js
       end
        
       # format.json { render :show, status: :ok, location: @article }
     else
       respond_to do |format|
         format.html { render :edit, status: :unprocessable_entity }
         format.json { render json: @article.errors, status: :unprocessable_entity }
       end
     end
   end
 
   # DELETE /articles/1 or /articles/1.json
   def destroy
     @article.destroy
 
     respond_to do |format|
       format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
       format.json { head :no_content }
     end
   end
 
   private
     # Use callbacks to share common setup or constraints between actions.
     def set_article
       @article = Article.find(params[:id])
     end
 
     # Only allow a list of trusted parameters through.
     def article_params
       params.require(:article).permit(:title, :description)
     end
 
     def require_same_user
       if current_user.id != @article.user.id
         flash[:danger]= "You can only edit or delete your own articles"
         redirect_to root_path
       end 
     end
   end