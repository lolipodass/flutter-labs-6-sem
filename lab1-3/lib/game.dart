
// 1. Интерфейс Game
abstract interface class Game {
  void play();
  void pause();
  String get name;
  set name(String name);
}

// 2. Абстрактный класс GameFactory
abstract class GameFactory {
  Game createGame();
  void publishGame(Game game);
}

// 3. Конкретные классы игр, реализующие интерфейс Game и наследующие GameFactory
class RPGGame extends GameFactory implements Game,Comparable<RPGGame> {
  String _name;

  // Конструктор и именованный конструктор
  RPGGame(this._name);
  RPGGame.Named(String name) : _name = "Named: $name";

  // Getter и Setter
  @override
  String get name => _name;
  @override
  set name(String name) => _name = name;

  // Имплементация методов интерфейса
  @override
  void play() {
    print("Playing RPG Game: $_name");
  }

  @override
  void pause() {
    print("Paused RPG Game: $_name");
  }

  // Реализация абстрактных методов
  @override
  Game createGame() => RPGGame("New RPG Game");

  @override
  void publishGame(Game game) {
    print("Publishing game: ${game.name}");
  }

  // Static поля и функции
  static String genre = "RPG";
  static void describeGenre() {
    print("RPG Games focus on story-driven gameplay.");
  }

  // Функция с различными типами параметров
  void updateSettings({bool? fullscreen,
    int resolutionWidth = 1920,
    Function? onSettingsUpdated,
    bool isMuted = false}) {
    print("Settings updated for $_name. Fullscreen: $fullscreen, Resolution: $resolutionWidth, Muted: $isMuted");
    if (onSettingsUpdated != null) {
      onSettingsUpdated();
    }
  }

  // Реализация интерфейса Comparable
  @override
  int compareTo(RPGGame other) {
    return _name.compareTo(other._name);
  }

  Map<String, dynamic> toJson() => {
    'name': _name,
    'genre': genre,
  };
}

mixin Playable {
  void play() => print("Playing game");
  void pause() => print("Game paused");
}


Stream<int> generateNumbers(int n) async* {
  for (int i = 0; i < n; i++) {
    await Future.delayed(const Duration(seconds: 1));
    yield i;
  }
}

Future<int> singleSubscriptionExample() async {
  Stream<int> numberStream = generateNumbers(5);
  await for (var number in numberStream) {
    print('Single-Subscription: $number');
  }
  return 0;
}

void broadcastStreamExample() {
  Stream<int> numberBroadcastStream = generateNumbers(5).asBroadcastStream();

  numberBroadcastStream.listen(
        (number) => print('Broadcast Listener 1: $number'),
    onDone: () => print('Listener 1 done.'),
  );

  numberBroadcastStream.listen(
        (number) => print('Broadcast Listener 2: $number'),
    onDone: () => print('Listener 2 done.'),
  );
}


// 4. Пример использования
void main() async {
  // Обработка исключений
  try {
    RPGGame skyrim = RPGGame("Skyrim");
    skyrim.play();
    skyrim.pause();
    skyrim.updateSettings(fullscreen: true, onSettingsUpdated: () => print("Settings were updated."));

    RPGGame.describeGenre();

    // List
    List<Game> games = [];
    games.add(skyrim);
    games.add(RPGGame.Named("Witcher 3"));

    // array
    List<Game> fixedSizeGames = List<Game>.filled(2, RPGGame.Named("Placeholder"), growable: false);
    fixedSizeGames[0] = RPGGame.Named("Dark Souls");
    fixedSizeGames[1] = RPGGame.Named("Bloodborne");

    //json
    Map<String, dynamic> gameMap = skyrim.toJson();
    print(gameMap);

    // Set
    Set<Game> uniqueGames = <Game>{};
    uniqueGames.add(skyrim);
    uniqueGames.add(RPGGame.Named("Witcher 3"));
    // Попытка добавить дубликат не изменит множество
    uniqueGames.add(RPGGame.Named("Witcher 3"));

    print("Unique games:");
    for (var game in uniqueGames) {
      print(game.name);
    }

    // Break continue
    print("Iterating over unique games with break and continue:");
    for (var game in uniqueGames) {
      if (game.name == "Skyrim") continue;
      print(game.name);
      if (game.name == "Witcher 3") break;
    }


    Future<Game> fetchGameAsync(String name) async {
      await Future.delayed(const Duration(seconds: 2));
      return RPGGame(name);
    }

    Stream<Game> gameStream(int count) async* {
      for (int i = 0; i < count; i++) {
        await Future.delayed(const Duration(seconds: 1));
        yield RPGGame("Game $i");
      }
    }



    // Пример использования асинхронного метода и Future
      fetchGameAsync("Async Game").then((game) => print(game.name));

      // Пример использования Stream
      await for (var game in gameStream(3)) {
        print("Streamed: ${game.name}");
      }

    print('--- Single-Subscription Stream Example ---');
      var result = await singleSubscriptionExample();

    print('\n--- Broadcast Stream Example ---');
    broadcastStreamExample();

  } catch (e) {
    print("An error occurred: $e");
  }
}
