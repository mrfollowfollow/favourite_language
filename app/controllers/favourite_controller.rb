class FavouriteController < ApplicationController
  
  before_filter :fav_lang
    

    
    require "http"
    require "json"
    
    def fav_lang
        @username = params[:username]
        github = HTTP.get("https://api.github.com/users/#{@username}/repos")
        
        return @result = "No username on Github matches #{@username}" if github.code == 404
        
        repo_info_string = github.to_s
        
        repo_info_hash = JSON.parse(repo_info_string)
        languages = repo_info_hash.map { |a| a.fetch('language') }.compact
        
        return @result = "No repos found for #{@username}" if languages.empty? == true
        
        lang_hash = languages.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
        fav = lang_hash.max_by { |v| v }[0]
        
        return @result = "#{@username}, Your favourite language is #{fav}"
    end
    
end
