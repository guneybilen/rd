class Notifier < ActionMailer::Base

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.email_friend.subject
  #




  # :to, :subject, :from - bu ucu gerekiyor methodlarda. yada
  # en yukarda class'dan sonra :default declare ediceksin




=begin

  def email_friend(job, sender_name, receiver_email)
    @job = job
    @sender_name = sender_name
    mail :to => receiver_email, :subject => t('general.interesting_job'), :from =>  "admin@isgetir.com"
  end
=end

  def comment_added(comment)
    @comment = comment
    @post = comment.post

    #puts "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% " + @job.user.email
    mail :to => @post.user.email,
         :subject => "Comment added", :from =>  "coffeelatte2007@gmail.com"
  end

  def user_added(user)
    @user = user
    mail :to => "guneybilen@yahoo.com",
         :subject => " #{@user.email}",
         :from =>  "coffeelatte2007@gmail.com"
  end

  def post_added(post)
    @post = post
    mail :to => "guneybilen@yahoo.com",
         :subject => "#{@post.user.email} " + "Post added",
         :from =>  "coffeelatte2007@gmail.com"
  end


  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password reset",
         :from =>  "coffeelatte2007@gmail.com"
  end
end

