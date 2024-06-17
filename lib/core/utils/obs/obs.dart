
import 'map.dart';

export 'list.dart';
export 'map.dart';
export 'rx_sorted_map.dart';
export 'rxlist.dart';
export 'rxmap.dart';
export 'rxsplay.dart';
export 'sorted_map.dart';

/// Possible operation kinds changing an observable iterable.
enum OperationKind { added, removed, updated }

/// Extension adding an ability to get [MapChangeNotification]s from [Stream].
extension MapChangesExtension<K, T> on Stream<Map<K, T>> {
  /// Gets [MapChangeNotification]s from [Stream].
  Stream<List<MapChangeNotification<K, T>>> changes() {
    Map<K, T> last = {};

    return asyncExpand((e) async* {
      final List<MapChangeNotification<K, T>> changed = [];

      for (final MapEntry<K, T> entry in e.entries) {
        final T? item = last[entry.key];
        if (item == null) {
          changed.add(MapChangeNotification.added(entry.key, entry.value));
        } else {
          if (entry.value != item) {
            changed.add(
              MapChangeNotification.updated(entry.key, entry.key, entry.value),
            );
          }
        }
      }

      for (final MapEntry<K, T> entry in last.entries) {
        final T? item = e[entry.key];
        if (item == null) {
          changed.add(MapChangeNotification.removed(entry.key, entry.value));
        }
      }

      last = e;

      yield changed;
    });
  }
}
