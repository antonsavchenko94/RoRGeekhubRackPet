class Cat
  def initialize name
    @name = name
    @asleep = false
    @food = 50
    @leisure = 20
    @health = 100
  end

  def getName
    return @name
  end

  def goToBed
    if (@health<=100)
      @asleep = true
      return 'Cat ' + @name + 'go sleep'
    else
      return @name + ' doesn`t want sleep '
    end
  end

  def play game
    if(@leisure <=100)
      if(game == 'Ball')
        @leisure = @leisure + 10
        @health = @health - 10
        return @name + ' play with Ball!!!'
      elsif(game == 'Laser')
        @health = @health - 10
        @leisure = @leisure + 20
        return @name + ' play with Laser!!!'
      end
    elsif(@leisure > 100)
      return @name + ' doesnt want play with Laser!!!'
    else
      return @name + ' doesnt want play !!'
    end

  end

  def getFood
    if (@food <= 100)
      return @name + ' want to eat'
    else
      return @name + 'doesn`t want eat'
    end
  end

  def feed
    if (@food <= 100)
      @food = @food + 10
      return @name + ' is feeding'
    else
      return @name + 'doesn`t want eat'
    end
  end

  def getStatus
    status = {}
    status['food'] = @food
    status['leisure'] = @leisure
    status['health'] = @health
    return status
  end
end

class Pet

  @@form = ' <form method="post" action="/create"> Cat name:<br> <input type="text" name="name" value=""> <input type="submit" value="Create"> </form>'
  @@feedForm = ' <form method="post" action="/feed"> Number of food:<br> <input type="text" name="feed" value="10"> <input type="submit" value="Feed"> </form>'
  @@actions = '<form action="/play"> Play with cat:<br> <input type="radio" name="game" value="Ball">Ball <br/> <input type="radio" name="game" value="Laser">Laser <br/> <input type="submit" value="Play"></form> <form action="/feed"> Feed cat:<br> <input type="submit" value="Feed"> </form> <form action="/goSleep"> Feed cat:<br> <input type="submit" value="Feed"> </form> <form action="/killcat"> Do you want kill your cat ?<br> <input type="submit" value="Feed"> </form>'

  @@cat = "  /\     /\
  {  `---'  }
  {  O   O  }
  ~~>  V  <~~
   \  \|/  /
    `-----'__
    /     \  `^\_
   {       }\ |\_\_   W
   |  \_/  |/ /  \_\_( )
    \__/  /(_E     \__/
      (  /
       MM"
  @@catPlay = "      /\_/\
 /\  / o o \
//\\ \~(*)~/
`  \/   ^ /
   | \|| ||
   \ '|| ||
    \)()-()"

  def call(env)
    req = Rack::Request.new(env)

    case req.path_info

      when /create/
        @pet = Cat.new(req["name"])
        [200, {"Content-Type" => "text/html"}, ["You now have a cat - #{@pet.getName} <br/> #{@@actions} <plaintext>#{@@cat}"]]

      when /feed/
        [200, {"Content-Type" => "text/html"}, ["You now have a cat - #{@name} <br/> #{@@actions} <span>#{@pet.feed}</span>  <plaintext>#{@@catPlay}"]]

      when /play/
        game = req["game"]
        [200, {"Content-Type" => "text/html"}, ["You now have a cat - #{@name} <br/> #{@@actions} <span>#{@pet.play(game)}</span>  <plaintext>#{@@catPlay}"]]

      when /killcat/
        [200, {"Content-Type" => "text/html"}, ["You're a bad host! You can't kill anyone!!!" ]]

      when /\//
        [200, {"Content-Type" => "text/html"}, ["#{@@form}"]]
      else
        path = req.path_info
        [404, {"Content-Type" => "text/html"}, ["#{path}"]]
    end
  end
end

run Pet.new
