class UserMailer < ApplicationMailer
  def verification_email(user, token)
    @user = user
    @token = token
    @verification_url = email_verification_url(@token)

    mail(
      to: @user.email,
      subject: "Please verify your email address"
    )
  end

  def password_reset
    @user = params[:user]

    mail(
      to: @user.email,
      subject: "🔐 Set a new password"
    )
  end

  def invite
    @user = params[:user]
    @link = params[:link]
    mail(
      to: params[:email],
      from: "Shitcoin Swap <noreply@shitcoinswap.com>",
      subject: "You've been invited to join Shitcoin Swap"
    )
  end
end
