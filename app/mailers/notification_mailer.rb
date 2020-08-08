class NotificationMailer < ApplicationMailer
  default from: "stu-suppo@example.com"

  def send_called_to_user(user, student)
    @user = user
    @student = student
    mail(
      subject: "連絡が来ています", #メールのタイトル
      to: @user.email #宛先
    ) do |format|
      format.text
    end
  end
end
