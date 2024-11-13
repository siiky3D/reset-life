import 'package:flutter/foundation.dart';
import 'package:my_app/src/features/statistics/data/local/local_relapse_repository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';
import 'package:sembast_web/sembast_web.dart';

class SembastRelapseRepository implements LocalRelapseRepository {
  SembastRelapseRepository(this.db);
  final Database db;
  final store = StoreRef.main();

  static Future<Database> createDatabase(String filename) async {
    if (!kIsWeb) {
      final appDocDir = await getApplicationDocumentsDirectory();
      return databaseFactoryIo.openDatabase('${appDocDir.path}/$filename');
    } else {
      return databaseFactoryWeb.openDatabase(filename);
    }
  }

  static Future<SembastRelapseRepository> makeDefault() async {
    return SembastRelapseRepository(await createDatabase('default.db'));
  }

  static const cartItemsKey = 'cartItems';

  @override
  Future<Relapse> fetchRelapse() async {
    final cartJson = await store.record(cartItemsKey).get(db) as String?;
    if (cartJson != null) {
      return Relapse.fromJson(cartJson);
    } else {
      return const Relapse();
    }
  }

  @override
  Future<void> setRelapse(Relapse cart) {
    return store.record(cartItemsKey).put(db, cart.toJson());
  }

  @override
  Stream<Relapse> watchRelapse() {
    final record = store.record(relapseItemsKey);
    return record.onSnapshot(db).map((snapshot) {
      if (snapshot != null) {
        return Relapse.fromJson(snapshot.value as String);
      } else {
        return const Relapse();
      }
    });
  }
}
