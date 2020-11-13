require_relative 'train'
require_relative 'cargotrain'
require_relative 'passengertrain'
require_relative 'station'
require_relative 'route'
require_relative 'carriage'
require_relative 'coach'

stations = {}
trains = {}
routes = {}

while true
  puts '1.Создать станцию'
  puts '2.Создать поезд'
  puts '3.Работа с маршрутом'
  puts '4.Назначить маршрут поезду'
  puts '5.Добавить вагон к поезду'
  puts '6.Отцепить вагон от поезда'
  puts '7.Переместить поезд по маршрут'
  puts '8.Просматривать список станций и список поездов на станции'
  puts '9.выход из программы'

  choice = gets.chomp.to_i

  if choice == 1
    puts 'Введите название станции'
    name_station = gets.chomp
    name_station_key = name_station
    name_station = Station.new(name_station)
    stations.merge!({ name_station_key => name_station })
    puts 'Станция создана!'
  end

  if choice == 2
    puts 'Введите название поезда'
    name_train = gets.chomp
    name_train_key = name_train
    puts 'Какой тип поезда: 1.Пассажирский 2.Грузовой'
    type = gets.to_i
    if type == 1
      name_train = PassengerTrain.new(name_train)
      trains.merge!({ name_train_key => name_train })
      puts 'Создан Пассажирский поезд'
    end
    if type == 2
      name_train = CargoTrain.new(name_train)
      trains.merge!({ name_train_key => name_train })
      puts 'Создан грузовой поезд'
    end

  end

  if choice == 3
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
      routes.merge!({ route_key => route })
      puts 'Маршрут создан'
    end

    if choice_menu_route == 2
      puts	'В какой маршрут добавить станцию'
      route = gets.chomp
      puts 'Какую станцию вы хотите добавить?'
      station = gets.chomp
      routes[route].add_station(stations[station])
      puts 'Станция добавлена в маршрут'
    end

    if choice_menu_route == 3
      puts 'Из какаого маршрута вы хотите удалить станцию'
      route = gets.chomp
      puts 'Какую станцию желате удалить?'
      station = gets.chomp
      routes[route].del_station(stations[station])
      puts 'Станция удалена из маршрута'
    end
  end

  if choice == 4
    puts 'Какой маршрут назначить?'
    route = gets.chomp
    puts 'Какому поезду назначить маршрут'
    train = gets.chomp
    trains[train].route_for_train(routes[route])
  end

  if choice == 5
    puts 'К какому поезду прицепить вагон?'
    train = gets.chomp
    if trains[train].instance_of?(CargoTrain)
      carriageee = Carriage.new
      trains[train].add_carriage(carriageee)
    else
      coachh = Coach.new
      trains[train].add_pass_carriage(coachh)
    end
    puts 'Вагон прицеплен'
  end

  if choice == 6
    puts 'От какого поезда отцепить вагон?'
    train = gets.chomp
    trains[train].del_carriage
  end
  if choice == 7
    puts 'Какой поезд переместить?'
    train = gets.chomp
    puts '1.Переместить на следующую станцию'
    puts '2.Переместить на предыдущую станцию'
    choice_move = gets.chomp
    trains[train].move_forward if choice_move == 1
    trains[train].move_backward if choice_move == 2
  end
  puts stations.values.each { |_train| puts station } if choice == 8

  break if choice == 9

end
