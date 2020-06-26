class ResultMailer < ApplicationMailer
  def new_result_mail
    @result = params[:result]
    @email = params[:email]
    mail(to: @email, subject: "We've decided!")
  end
end
