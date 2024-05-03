import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/games.dart';

const String WORKER_COLLECTION_REF = "games";

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference _gamesRef;

  DatabaseService() {
    _gamesRef =
        _firestore.collection(WORKER_COLLECTION_REF).withConverter<Game>(
            fromFirestore: (snapshots, _) => Game.fromJson(
                  snapshots.data()!,
                ),
            toFirestore: (worker, _) => worker.toJson());
  }

  Stream<QuerySnapshot> getGames() {
    return _gamesRef.snapshots();
  }

  void addGame(Game worker) async {
    _gamesRef.add(worker);
  }

  void updateGame(String workerId, Game worker) async {
    _gamesRef.doc(workerId).update(worker.toJson());
  }

  void deleteGame(String workerId) async {
    _gamesRef.doc(workerId).delete();
  }
}
