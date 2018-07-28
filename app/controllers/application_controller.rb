
require_relative '../../config/environment'
require 'pry'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/posts/new' do
    erb :'posts/new'
  end
  
  post '/posts' do
    Post.create do |p|
      params.each do |key, value|
        p.send("#{key}=", value)
      end
      p.save
    end
    erb :'posts/index'
  end
  
  get '/posts' do
    @posts = Post.all    
    erb :'posts/index'
  end
 
  get '/posts/:id/edit' do
    @post = Post.find(params[:id])
    erb :'posts/edit'
  end
  
  get '/posts/:id' do
    @post = Post.find(params[:id])

    erb :'posts/show'
  end
  
  patch '/posts/:id' do
    @post = Post.find(params[:id])
    @post.update(name: params[:name], content: params[:content])
    @post.save

    erb :'posts/show'    
  end
  
  delete '/posts/:id/delete' do
    @post = Post.find(params[:id])
    @post.delete
  end
  
end
