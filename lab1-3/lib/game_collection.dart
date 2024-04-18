import 'game.dart';

class GameIterator implements Iterator<Game> {
  final List<Game> _games;
  int _currentIndex = -1;

  GameIterator(this._games);

  @override
  bool moveNext() {
    if (_currentIndex < _games.length - 1) {
      _currentIndex++;
      return true;
    }
    return false;
  }

  @override
  Game get current => _games[_currentIndex];
}

class GameCollection implements Iterable<Game> {
  final List<Game> _games = [];

  void add(Game game) => _games.add(game);

  @override
  Iterator<Game> get iterator => GameIterator(_games);

  @override
  bool any(bool Function(Game element) test)=>_games.any(test);

  @override
  Iterable<R> cast<R>()=> _games.cast();

  @override
  bool contains(Object? element)=>_games.contains(element);

  @override
  Game elementAt(int index)=> _games.elementAt(index);

  @override
  bool every(bool Function(Game element) test)=> _games.every(test);

  @override
  Iterable<T> expand<T>(Iterable<T> Function(Game element) toElements)=>_games.expand(toElements);

  @override
  Game get first => _games.first;

  @override
  Game firstWhere(bool Function(Game element) test,{Game Function()? orElse}) =>_games.firstWhere(test, orElse: orElse);

  @override
  T fold<T>(T initialValue, T Function(T previousValue, Game element) combine)=> _games.fold(initialValue, combine);

  @override
  Iterable<Game> followedBy(Iterable<Game> other)=> _games.followedBy(other);

  @override
  void forEach(void Function(Game element) action)=> _games.forEach(action);

  @override
  bool get isEmpty => _games.isEmpty;

  @override
  bool get isNotEmpty => _games.isNotEmpty;

  @override
  String join([String separator = ""])=> _games.join(separator);

  @override
  Game get last => _games.last;

  @override
  Game lastWhere(bool Function(Game element) test,{Game Function()? orElse}) =>_games.lastWhere(test, orElse: orElse);

  @override
  int get length => _games.length;

  @override
  Iterable<T> map<T>(T Function(Game e) toElement)=> _games.map(toElement);

  @override
  Game reduce(Game Function(Game value, Game element) combine)=> _games.reduce(combine);

  @override
  Game get single => _games.single;

  @override
  Game singleWhere(bool Function(Game element) test,{Game Function()? orElse})=> _games.singleWhere(test, orElse: orElse);

  @override
  Iterable<Game> skip(int count)=> _games.skip(count);

  @override
  Iterable<Game> skipWhile(bool Function(Game value) test)=> _games.skipWhile(test);

  @override
  Iterable<Game> take(int count)=> _games.take(count);

  @override
    Iterable<Game> takeWhile(bool Function(Game value) test)=> _games.takeWhile(test);

  @override
  List<Game> toList({bool growable = true})=> toList(growable: growable);

  @override
  Set<Game> toSet()=> _games.toSet();

  @override
  Iterable<Game> where(bool Function(Game element) test)=> _games.where(test);

  @override
  Iterable<T> whereType<T>()=> _games.whereType<T>();
}
