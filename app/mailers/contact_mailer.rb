class ContactMailer < ApplicationMailer

  def contact(player)
    @player = player
    mail(to: 'contact@test.fr', subject: 'Sujet de test')
  end

end
