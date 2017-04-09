require "rails_helper"

RSpec.describe FavouriteController, :type => :controller do

    it "return error when no github username is found" do 
        @username = "nogithubuserwiththisusername"
        @result  = controller.fav_lang(@username)
        expect(@result).to eql("No username on Github matches #{@username}")
    end


    it "return error when no github repos are found" do 
        @username = "ydimitrov"
        @result = controller.fav_lang(@username)
        expect(@result).to eql("No repos found for #{@username}")
    end
    
    it "should return correct result" do
        @username = "mrfollowfollow"
        @result = controller.fav_lang(@username)
        expect(@result).to eql("#{@username}, Your favourite language is JavaScript")
    end
end