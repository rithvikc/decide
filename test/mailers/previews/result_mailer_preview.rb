# Preview all emails at http://localhost:3000/rails/mailers/result_mailer
class ResultMailerPreview < ActionMailer::Preview
  def new_result_mail
    @result = Result.new(event_id: 1, restaurant_id: 1)
    @result.save!
    ResultMailer.with(result: @result).new_result_mail
  end
end
