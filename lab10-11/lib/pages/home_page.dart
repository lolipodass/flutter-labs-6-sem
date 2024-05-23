import 'package:flutter/material.dart';
import 'package:flutter_application_1/db_services.dart';
import '../models/games.dart';
import 'package:flutter/widgets.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final DatabaseService _databaseService = DatabaseService();
  final nameController = TextEditingController();
  final specializationController = TextEditingController();

  final nameController2 = TextEditingController();
  final specializationController2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBar(),
      body: _buildUI(),
      floatingActionButton: FloatingActionButton(
        key: ValueKey('addButton'),
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          _addDialog();
        },
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      backgroundColor: Colors.blue,
      centerTitle: true,
      title: const Text(
        'Games',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildUI() {
    return SafeArea(
        child: Column(
      children: [
        _messagesListView(),
      ],
    ));
  }

  Widget _messagesListView() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width,
      child: StreamBuilder(
        stream: _databaseService.getGames(),
        builder: (context, snapshot) {
          List games = snapshot.data?.docs ?? [];
          if (games.isEmpty) {
            return Center(
              child: Text('Add a Game!'),
            );
          }
          return ListView.builder(
            itemCount: games.length,
            itemBuilder: (context, index) {
              Game game = games[index].data();
              String gameId = games[index].id;

              return Draggable(
                feedback: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(10.0), // Закругление углов
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    child: ListTile(
                      tileColor: Colors.blue[300],
                      title: Text("Name: ${game.name}",
                          style: TextStyle(color: Colors.white)),
                      subtitle: Text("Plantform: ${game.platform}",
                          style: TextStyle(color: Colors.white)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue[800]),
                            onPressed: () {
                              _editDialog(
                                  game, game.name, game.platform, gameId);
                            },
                          ),
                          IconButton(
                            onPressed: () {
                              _databaseService.deleteGame(gameId);
                            },
                            icon: Icon(Icons.delete, color: Colors.blue[800]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                childWhenDragging: Container(),
                feedbackOffset: Offset(0, -20),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    tileColor: Colors.blue[300],
                    title: Text(
                      "Name: ${game.name}",
                      style: TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      "Platform: ${game.platform}",
                      style: TextStyle(color: Colors.white),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue[800]),
                          onPressed: () {
                            _editDialog(game, game.name, game.platform, gameId);
                          },
                        ),
                        IconButton(
                          onPressed: () {
                            _databaseService.deleteGame(gameId);
                          },
                          icon: Icon(Icons.delete, color: Colors.blue[800]),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _editDialog(
      Game game, String name, String specialization, String gameId) async {
    nameController.text = name;
    specializationController.text = specialization;

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            title: Text('Изменить'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    key: ValueKey('addField'),
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: specializationController,
                    decoration: const InputDecoration(labelText: 'Platform'),
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Закрыть')),
              TextButton(
                  onPressed: () async {
                    Game updatedGame = game.copyWith(
                        name: nameController.text.toString(),
                        platform: specializationController.text.toString());
                    _databaseService.updateGame(gameId, updatedGame);

                    nameController.clear();
                    specializationController.clear();
                    Navigator.pop(context);
                  },
                  child: Text('Изменить')),
            ],
          );
        });
  }

  void _addDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            title: const Text('Add Game'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController2,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: specializationController2,
                    decoration: const InputDecoration(labelText: 'platform'),
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Закрыть')),
              TextButton(
                  onPressed: () async {
                    Game game = Game(
                        name: nameController2.text.toString(),
                        platform: specializationController2.text.toString());
                    _databaseService.addGame(game);
                    specializationController2.clear();
                    nameController2.clear();

                    Navigator.pop(context);
                  },
                  child: Text('Добавить')),
            ],
          );
        });
  }
}
