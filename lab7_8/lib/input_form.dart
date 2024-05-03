import 'package:flutter/material.dart';
import 'package:lab7_8/game.dart';
import 'package:lab7_8/database/game_db.dart';
import 'package:sqflite/sqflite.dart';

// ignore: must_be_immutable
class InputForm extends StatelessWidget {
  final Game? game;
  final Database? db;
  String? gameTitle;
  double? gameRating;

  InputForm({super.key, required this.game, required this.db});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    if (game != null) {
      gameTitle = game!.title;
      gameRating = game!.rating;
    }

    return Scaffold(
        body: SafeArea(
      child: Container(
          margin: const EdgeInsets.all(25),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FloatingActionButton(
                    child: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 0),
                      child: TextFormField(
                        initialValue: gameTitle,
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Enter game name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onChanged: (value) =>
                            {gameTitle = value.trim().toLowerCase()},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        initialValue: gameRating.toString() == "null"
                            ? ''
                            : gameRating.toString(),
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Enter game rating'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        onChanged: (value) => {
                          gameRating =
                              double.tryParse(value.trim().toLowerCase())
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.purple,
                              side: const BorderSide(
                                color: Colors.purple,
                              ),
                            ),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                if (game == null) {
                                  await GameDB.create(
                                      database: db!,
                                      title: gameTitle!,
                                      rating: gameRating!);
                                } else {
                                  await GameDB.update(
                                      database: db!,
                                      id: game!.id,
                                      title: gameTitle!,
                                      rating: gameRating!);
                                }
                                Navigator.pop(context, true);
                              }
                            },
                            child: const Text("Save"),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    ));
  }
}
