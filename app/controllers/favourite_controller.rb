class FavouriteController < ApplicationController
  
  before_filter :get_username
    
    require "http"
    require "json"
    
    def get_username 
      @username = params[:username]
      fav_lang(@username)
    end
    
    def fav_lang(u)
        
        github = HTTP.get("https://api.github.com/users/#{u}/repos")
        
        return @result = "No username on Github matches #{u}" if github.code == 404

        repo_info = JSON.parse(github.to_s)
        languages = repo_info.map { |a| a.fetch('language') }.compact
        
        return @result = "No repos found for #{u}" if languages.empty? == true
        
        lang_hash = languages.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
        fav = lang_hash.max_by { |v| v }[0]
        
        return @result = "#{u}, Your favourite language is #{fav}"
    end
  
    
end
