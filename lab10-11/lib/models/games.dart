import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Game {
  final String name;
  final String platform;

  Game({required this.name, required this.platform});

  Game.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        platform = json['platform'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'platform': platform,
      };

  Game copyWith({String? name, String? platform}) {
    return Game(
      name: name ?? this.name,
      platform: platform ?? this.platform,
    );
  }
}
