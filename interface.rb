class Interface
  attr_reader :stations, :trains, :routes

  def initialize
    @stations = {}
    @trains = {}
    @routes = {}
  end

  def menu
    loop do
      puts '1.Создать станцию'
      puts '2.Создать поезд'
      puts '3.Работа с маршрутом'
      puts '4.Назначить маршрут поезду'
      puts '5.Добавить вагон к поезду'
      puts '6.Отцепить вагон от поезда'
      puts '7.Переместить поезд по маршрут'
      puts '8.Информация'
      puts '9.выход из программы'

      choice = gets.chomp.to_i

      case choice
      when 1
        create_station
      when 2
        create_train
      when 3
        work_on_the_route
      when 4
        assign_route
      when 5
        attach_car
      when 6
        unhook_car
      when 7
        move_train
      when 8
        info
      else break
      end
    end
  end

  private # доступ к данным методам осуществляется через метод--> menu

  def create_station
    puts 'Введите название станции'
    name_station = gets.chomp
    name_station_key = name_station
    name_station = Station.new(name_station)
    @stations.merge!({ name_station_key => name_station })
    puts 'Станция создана!'
  end

  def create_train
    puts 'Введите название поезда'
    name_train = gets.chomp
    name_train_key = name_train
    puts 'Какой тип поезда: 1.Пассажирский 2.Грузовой'
    type = gets.to_i
    if type == 1
      name_train = PassangerTrain.new(name_train)
      @trains.merge!({ name_train_key => name_train })
      puts 'Создан Пассажирский поезд'
    elsif type == 2
      name_train = CargoTrain.new(name_train)
      @trains.merge!({ name_train_key => name_train })
      puts 'Создан грузовой поезд'
    end
  rescue RuntimeError => e
    puts e.massage e.message == 'Неверный формат номера'
  end

  def work_on_the_route
    puts '1.Создать маршрут'
    puts '2.Добавить станцию в маршрут'
    puts '3.Удалить станцию из маршрута'
    choice_menu_route = gets.chomp.to_i
    if choice_menu_route == 1
      puts 'Введите название маршрута'
      route = gets.chomp
      puts 'Введите начальную станцию'
      st1 = gets.chomp
      puts 'Введите конечную станцию'
      st2 = gets.chomp
      route_key = route
      route = Route.new(stations[st1], stations[st2])
      @routes.merge!({ route_key => route })
      puts 'Маршрут создан'
    end

    if choice_menu_route == 2
      puts  'В какой маршрут добавить станцию'
      route = gets.chomp
      puts 'Какую станцию вы хотите добавить?'
      station = gets.chomp
      @routes[route].add_station(@stations[station])
      puts 'Станция добавлена в маршрут'
    end

    if choice_menu_route == 3
      puts 'Из какаого маршрута вы хотите удалить станцию'
      route = gets.chomp
      puts 'Какую станцию желате удалить?'
      station = gets.chomp
      @routes[route].del_station(@stations[station])
      puts 'Станция удалена из маршрута'
    end
  end

  def assign_route
    puts 'Какой маршрут назначить?'
    route = gets.chomp
    puts 'Какому поезду назначить маршрут'
    train = gets.chomp
    @trains[train].route_for_train(@routes[route])
  end

  def attach_car
    puts 'К какому поезду прицепить вагон?'
    train = gets.chomp
    puts 'Какой прицепить вагон'
    puts '1. Пассажирский'
    puts '2. Грузовой'
    choice_carriage = gets.chomp
    if choice_carriage == '1'
      puts 'Укажите количество мест в вагоне'
      seats = gets.to_i
      carriage = PassangerCarriage.new(seats)
      puts '1.Занять место в вагоне?'
      puts '0.Не нужно'
      get_seat = gets.to_i
      if get_seat == 1
        puts 'Сколько мест занять?'
        gets_seat = gets.to_i
        carriage.to_take_seats(gets_seat)
      end
    elsif choice_carriage == '2'
      puts 'Укажите объём грузового вагона'
      volume = gets.to_i
      carriage = CargoCarriage.new(volume)
      puts '1.Занять объём'
      puts '0.Не нужно'
      gete_volu = gets.to_i
      if gete_volu == 1
        puts 'Сколько занять объёма'
        valuee = gets.to_i
        carriage.to_fill(valuee)
      end
    end
    @trains[train].add_carriage(@trains[train], carriage)
  end

  def unhook_car
    puts 'От какого поезда отцепить вагон?'
    train = gets.chomp
    @trains[train].del_carriage
  end

  def move_train
    puts 'Какой поезд переместить?'
    train = gets.chomp
    puts '1.Переместить на следующую станцию'
    puts '2.Переместить на предыдущую станцию'
    choice_move = gets.chomp
    @trains[train].move_forward if choice_move == 1
    @trains[train].move_backward if choice_move == 2
  end

  def info
    puts '1.Вывести список вагонов у поезда'
    puts '2.Вывести список поездов на станции'
    choice_info = gets.to_i
    if choice_info == 1
      block = proc do |carriage|
        puts "Номер вагона: #{carriage}"
        if carriage.type == 'pass'
          puts 'Тип вагона: Пассажирский'
          puts "количество свободных мест: #{carriage.number_free_place}"
          puts "количество занятых мест: #{carriage.number_of_place_taken}"
        else
          puts 'Тип вагона: Грузовой'
          puts "Свободный объём: #{carriage.free_volume}"
          puts "Занятый объём: #{carriage.to_fill_volume}"
        end
      end
      puts 'Укажите номер поезда'
      train = gets.chomp
      @trains[train].block_carriage(&block)
    else
      block = proc do |train|
        puts "Номер поезда: #{train.number}"
        puts 'Тип поезда: Пассажирский' if train.type == 'pass'
        puts 'Тип поезда: Грузовой' if train.type == 'cargo'
        puts "Количество вагонов: #{train.carriage.size}"
      end
      puts 'Введите название станции'
      station = gets.chomp
      @stations[station].block_carriage(&block)
    end
  end
end
