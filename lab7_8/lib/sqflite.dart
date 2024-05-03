import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'game.dart';
import 'database/game_db.dart';
import 'database/database_service.dart';
import 'input_form.dart';

const List<String> directories = [
  'TemporaryDirectory',
  'ApplicationDocumentsDirectory',
  'ApplicationSupportDirectory',
  'ExternalStorageDirectory',
  'ExternalCacheDirectories'
];

String? dropdownValue;
final directoryState = ValueNotifier<Directory?>(null);
DatabaseService databaseService = DatabaseService();

class SqflitePage extends StatelessWidget {
  const SqflitePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          child: const Text(
            "Sqflite",
            style: TextStyle(
                color: Colors.black,
                fontSize: 32,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none),
          ),
        ),
        const DropdownButtonExample(),
        Container(
          height: 300,
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
          child: const GamesList(),
        ),
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: FloatingActionButton(
            onPressed: () async {
              Database? db = await databaseService.database;
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InputForm(game: null, db: db)))
                  .then((value) async {
                if (value == true) {
                  // setDirectoryState();
                }
              });
            },
            child: const Icon(Icons.add),
          ),
        )
      ],
    );
  }
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      hint: const Text('Select directory'),
      onChanged: (String? value) async {
        setState(() {
          dropdownValue = value;
          print(dropdownValue);
          setDirectoryState(value);
        });
      },
      items: directories.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

Future<void> setDirectoryState(String? value) async {
  Directory? directory;
  print(value);
  value ??= "";
  switch (directories.indexOf(value)) {
    case 0:
      directory = await getTemporaryDirectory();
    case 1:
      directory = await getApplicationDocumentsDirectory();
    case 2:
      directory = await getApplicationSupportDirectory();
    case 3:
      directory = await getExternalStorageDirectory();
    case 4:
      await getExternalCacheDirectories()
          .then((value) => directory = value?.first);
    default:
      directory = await getTemporaryDirectory();
      break;
  }

  await databaseService.database.then((value) => value?.close());
  await databaseService.setStorage(directory!.path);
  directoryState.value = directory;
}

class GamesList extends StatefulWidget {
  const GamesList({super.key});

  @override
  State<GamesList> createState() => _GamesListState();
}

class _GamesListState extends State<GamesList> {
  Future<List<Game>> fetchData() async {
    Database? db = await databaseService.database;
    return await GameDB.fetchAll(db!);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: directoryState,
        builder: (context, value, child) {
          return FutureBuilder<List<Game>>(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  final games = snapshot.data;
                  if (games == null || games.isEmpty) {
                    return const Text(
                      'No records',
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    );
                  } else {
                    return ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemCount: games.length,
                      itemBuilder: (context, index) {
                        final game = games[index];
                        final subtitle = game.rating;

                        return ListTile(
                          title: Text(game.title,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text(subtitle.toString()),
                          trailing: IconButton(
                              onPressed: () async {
                                Database? db = await databaseService.database;
                                await GameDB.delete(database: db!, id: game.id);
                                await setDirectoryState(dropdownValue);
                              },
                              icon:
                                  const Icon(Icons.delete, color: Colors.red)),
                          onTap: () async {
                            Database? db = await databaseService.database;
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            InputForm(game: game, db: db!)))
                                .then((value) async {
                              await setDirectoryState(dropdownValue);
                            });
                          },
                        );
                      },
                    );
                  }
                }
              });
        });
  }
}
