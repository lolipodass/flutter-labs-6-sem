import 'package:flutter_application_1/models/games.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';

class MockJsonMap extends Mock implements Map<String, Object?> {}

void main() {
  group('Game', () {
    late Game game;
    late Map<String, Object?> mockJson;

    setUp(() {
      mockJson = MockJsonMap();
      when(mockJson['name']).thenReturn('Dark');
      when(mockJson['platform']).thenReturn('Fantasy');

      game = Game.fromJson(mockJson);
    });

    test('fromJson() should create a Game object from JSON data', () {
      expect(game.name, 'GTA 5');
      expect(game.platform, 'Shooter');
    });

    test('copyWith() should create a new Game object with updated values', () {
      final updatedBakery =
          game.copyWith(name: 'World of tanks', platform: 'simulator');

      expect(updatedBakery.name, 'World of tanks');
      expect(updatedBakery.platform, 'simulator');
    });

    test('toJson() should convert Game object to JSON data', () {
      final json = game.toJson();

      expect(json['name'], 'GTA 5');
      expect(json['platform'], 'Shooter');
    });
  });
}
