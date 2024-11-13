import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_relapse_repository.g.dart';

/// API for reading, watching and writing local cart data (guest user)
abstract class LocalRelapseRepository {
  Future<Relapse> fetchRelapse();

  Stream<Relapse> watchRelapse();

  Future<void> setRelapse(Relapse cart);
}

@Riverpod(keepAlive: true)
LocalRelapseRepository localCartRepository(LocalRelapseRepositoryRef ref) {
  throw UnimplementedError();
}
