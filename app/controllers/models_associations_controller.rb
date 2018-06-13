class ModelsAssociationsController < ApplicationController
  # Association for player
  def add_player_game
  	# Association dans le profile joueur
  	current_user.games < @game
  end

  # # def add_player_sponsor
  # # 	# Un joueur ne peut pas ajouter de sponsor
  # # 	current_user.sponsors < @sponsor
  # end

  def add_player_event
  	# Association dans les pages events
  	current_user.sponsors < @event
  end
  # Association for sponsor
  def add_sponsor_player
  	# Association dans le profile sponsor
  	current_user.players < @player
  end

  def add_sponsor_event
  	# Association dans le profil sponsor
    current_user.events < @event
  end

  def add_sponsor_game
  	# Association dans le profil sponsor
  	current_user.games < @game
  end
  # Association for event
  # def add_event_player
  # 	# un event ne peut pas ajouter de joueur
  # 	@event.players < current_user
  # end

  # def add_event_sponsor
  # 	# un event de ne peut pas ajouter de sponsor
  # 	@event.sponsors < current_user
  # end

  def add_event_game
  	# Association a la creation de l'event (automatique)
  	# Association par le scrapping non manuel
  	# Car il n'y a pas de session event
  	@event.games < @game
  end
  # Association for game
  # def add_game_player
  # 	# Un jeu ne peut pas ajouter de player
  # 	@game.players < current_user
  # end 
  
  # def add_game_event
  #   # Un jeu ne peut pas ajouter d'event
  # 	@game.events < @event
  # end

  # def add_game_sponsor
  # 	# Un jeu ne peut pas ajouter de sponsor
  # 	@game.sponsors < current_user
  # end

end