class BlogMailer < ApplicationMailer
default from: "dayanthan86@gmail.com"

 def blog_invitation(current_user,user_list,title)
	@user_list=user_list
   @title = title
	mail(:to => @user_list, :subject => "A replacement clerk has been requested")
 end
 
end
