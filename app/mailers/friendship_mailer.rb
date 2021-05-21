class FriendshipMailer < ApplicationMailer

    def new_follower(user, friendUser)
        @user = user
        @friendUser = friendUser
        mail(to: friendUser.email, subject: 'Tienes un nuevo seguidor!')
    end

end