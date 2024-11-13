import 'package:my_app/src/features/statistics/data/local/local_relapse_repository.dart';
import 'package:my_app/src/utils/delay.dart';
import 'package:my_app/src/utils/in_memory_store.dart';

class FakeLocalCartRepository implements LocalRelapseRepository {
  FakeLocalCartRepository({this.addDelay = true});
  final bool addDelay;

  final _relapse = InMemoryStore<Relapse>(const Relapse());

  @override
  Future<Relapse> fetchRelapse() => Future.value(_relapse.value);

  @override
  Stream<Relapse> watchRelapse() => _relapse.stream;

  @override
  Future<void> setRelapse(Relapse relapse) async {
    await delay(addDelay);
    _relapse.value = relapse;
  }
}
