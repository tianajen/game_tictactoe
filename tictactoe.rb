
require 'pry'

class Board
    @@tab = [] # On creer un tableau,une constante de la classe Board, qui va contenir tout les positions 3x3 des joueurs
    
    def initialize
        # Les 9 instances de Board_case
        case1 = Board_case.new
        case2 = Board_case.new
        case3 = Board_case.new
        case4 = Board_case.new
        case5 = Board_case.new
        case6 = Board_case.new
        case7 = Board_case.new
        case8 = Board_case.new
        case9 = Board_case.new

        # On insert les instances dans le tableau
        @@tab = [[case1,case2,case3],[case4,case5,case6],[case7,case8,case9]]
    end
    
    def set_position(position, player)
         # Si la position est un " ", on insert le joueur dans la case
        if @@tab[position[0]][position[1]].status == " "
            @@tab[position[0]][position[1]].status = player
        end
    end

    # permet de recuperer celui qui occipe la case en question
    def verify_case(position)
        @@tab[position[0]][position[1]].status
    end

    # Verifie si le jeux est fini
    def game_over(player)
        if @@tab[0][0].status == player && @@tab[0][1].status == player && @@tab[0][2].status == player # verifie si des points sont alignés au 1er lignes
            true
        elsif @@tab[1][0].status == player && @@tab[1][1].status == player && @@tab[1][2].status == player # verifie si des points sont alignés au 2é lignes
            true
        elsif @@tab[2][0].status == player && @@tab[2][1].status == player && @@tab[2][2].status == player # verifie si des points sont alignés au 3é lignes
            true
        elsif @@tab[0][0].status == player && @@tab[1][1].status == player && @@tab[2][2].status == player # verifie si des points sont alignés en oblique
            true
        elsif @@tab[0][2].status == player && @@tab[1][1].status == player && @@tab[2][0].status == player # verifie si des points sont alignés en oblique
            true
        elsif @@tab[0][0].status == player && @@tab[1][0].status == player && @@tab[2][0].status == player # verifie si des points sont alignés en vertical sur la colonne 1
            true
        elsif @@tab[0][1].status == player && @@tab[1][1].status == player && @@tab[2][1].status == player # verifie si des points sont alignés en vertical sur la colonne 2
            true
        elsif @@tab[0][2].status == player && @@tab[1][2].status == player && @@tab[2][2].status == player # verifie si des points sont alignés en vertical sur la colonne 3
            true
        else
            false
        end
    end

    # Pour afficher le plateau du jeux
    def view_board
        row = ["A","B","C"]
        i = 0
        puts "     1   2   3"
        puts "    ___________"
        @@tab.each do |y|
            puts "#{row[i]}: | #{y[0].status} | #{y[1].status} | #{y[2].status} |"
            puts "   |___________|"
            i +=1
        end
    end
end


#On crée une classe Board_case qui va nous renseigner l'etat d'une case
#Soit la case est vide(au depart), soit elle a comme valeur X ou O
class Board_case
    attr_accessor :status
    def initialize(status=" ")
        @status = status
    end
end

#Voici la classe du joueur qui a comme attribut son nom et son etat de victoire
class Player
    attr_accessor :name, :victory
    def initialize(name, victory)
        @name = name
        @victory = victory
    end
end

class Game
  # Initialize le jeux
  def initialize
    @positions = {
        :A1 => [0,0],
        :A2 => [0,1],
0        :A3 => [0,2],
        :B1 => [1,0],
        :B2 => [1,1],
        :B3 => [1,2],
        :C1 => [2,0],
        :C2 => [2,1],
        :C3 => [2,2]
    }
    @gamer1 = Player.new("inconnu",false)
    @gamer2 = Player.new("inconnu",false)
    @plateau = nil
  end
  # permet de lancer le jeux
  def play
    rematch = true
    while rematch == true do
        @plateau = Board.new
        tour = 1
        puts "-----------------------------------------------------------------------------------"
        puts "|                    Welcome to the game Tic-tac-toe !!!                         |"
        puts "-----------------------------------------------------------------------------------"
        puts "Veuillez entrer le nom du Joueur X:"
        a = gets.chomp # On demande le nom du premier joueur
        puts "Veuillez entrer le nom du Joueur O:"
        b = gets.chomp # On demande le nom du second joueur

        @gamer1.name = a # On enregistre le nom du premier joueur
        @gamer2.name = b # On enregistre le nom du second joueur
    
        while tour != 10 do
            @plateau.view_board # On affiche le plateau de jeux
            puts "\n"
            if tour % 2 == 0 # Quand c'est le tour du deuxieme joueur
                puts "Au tour du joueur O (#{@gamer2.name.capitalize})"
                p = gets.chomp # On l'invite a saisir une position

                # Tant que la case n'existe pas, on demande au joueur O de resaisir une position existante
                while !@positions[p.upcase.to_sym]  do 
                    puts "Cette position n'existe pas #{@gamer2.name.capitalize}, veuillez resaisir:" 
                    p = gets.chomp
                end

                # Tant que la case n'est pas vide on l'invite a choisir une autre case
                while @plateau.verify_case(@positions[p.upcase.to_sym]) != " "  do
                    puts "Cette position est deja prise #{@gamer2.name.capitalize}, veuillez resaisir:" 
                    p = gets.chomp
                end

                # On attribue la case au joueur O
                @plateau.set_position(@positions[p.upcase.to_sym], "O")

                # On verifie si le joueur O gagne
                if @plateau.game_over("O") # Si oui, on arrete le jeux et le joueur O gagne
                    tour = 10
                    @j2.victory = true
                else
                    tour += 1 # Sinon, on passe au tour suivant
                end
            else
                puts "Au tour du joueur X (#{@gamer1.name.capitalize})"# Quand c'est le tour du premier joueur
                p = gets.chomp # On l'invite a saisir une position

                # Tant que la case n'existe pas, on demande au joueur X de resaisir une position existante
                while !@positions[p.upcase.to_sym] do 
                    puts "Cette position n'existe pas #{@gamer1.name.capitalize}, veuillez resaisir:" 
                    p = gets.chomp
                end

                # Tant que la case n'est pas vide on l'invite a choisir une autre case
                while @plateau.verify_case(@positions[p.upcase.to_sym]) != " "  do
                    puts "Cette position est deja prise #{@j1.name.capitalize}, veuillez resaisir:" 
                    p = gets.chomp
                end

                # On attribue la case au joueur O
                @plateau.set_position(@positions[p.upcase.to_sym], "X")

                # On verifie si le joueur X gagne
                if @plateau.game_over("X")# Si oui, on arrete le jeux et le joueur X gagne
                    tour = 10
                    @j1.victory = true
                else
                    tour += 1 # Sinon, on passe au tour suivant
                end
            end
        end
    
        # On affiche le resultat du plateau de jeu final
        @plateau.view_board
    
        # On check ce qui a gagne ou si c'etait un match nul
        if @j1.victory == true
            puts "Bravo #{@gamer1.name.upcase}! T'as gagné !!!!"
         elsif @j2.victory == true
            puts "Bravo #{@gamer2.name.upcase}! T'as gagné !!!!"
        elseclass Board_case
        attr_accessor :status
            def initialize(status=" ")
                @status = status
            end
            puts "Match nul!!!!!"
        end

        # On invite les joueurs a faire une autre partie
        puts "\n\nFaire une revenche?\n1- Oui\n2- Non"
        v = gets.chomp
        quit = false
        while quit != true do
            if v == "1"
                quit = true
            elsif v == "2"
                quit = true
                rematch = false
                puts "Merci d'etre passe !!! :)"
            else
                quit = false
                puts "\n\nTapez:\n1- Pour recommencer\n2- Pour quitter"
                v = gets.chomp
            end
        end
    end
end
end


g = Game.new  #On genere un nouveau jeu

g.play  #On joue