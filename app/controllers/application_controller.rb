require 'pry'
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  

  get "/articles/new"  do #> Works
    erb :new
  end

  post "/articles" do
    art = Article.create(params)
    redirect to :"/articles/#{art.id}"
  end

  get "/articles" do
    @articles = Article.all
    erb :index
  end

  get "/articles/:id" do
    @article = Article.find(params[:id])
    erb :show
  end

  get "/articles/:id/edit" do
    @article = Article.find(params[:id])
    erb :edit
  end

  patch "/articles/:id" do
    @article = Article.find_by(id: params[:id])
    @article.update(params[:article])
    @article.save
    redirect to :"/articles/#{@article.id}"
  end
  
  delete "/articles/:id" do
    @article = Article.find_by(id: params[:id])
    @article.destroy
    redirect to :index
  end
end
