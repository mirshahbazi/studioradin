
import 'dart:collection';

import 'map.dart';

/// Self-sorting observable [Map].
class SortedObsMap<K, V> extends MapMixin<K, V> {
  SortedObsMap([Comparator<V>? compare])
      : _compare = compare ?? _defaultCompare<V>();

  /// Callback, comparing the provided [V] items.
  final Comparator<V> _compare;

  /// [Map] for an constant complexity for getting elements by its keys.
  final ObsMap<K, V> _keys = ObsMap();

  /// [SplayTreeSet] of the sorted [V] values.
  late final SplayTreeSet<V> _values = SplayTreeSet(_compare);

  /// Unsorted [K] keys.
  @override
  Iterable<K> get keys => _keys.keys;

  @override
  Iterable<V> get values => _values;

  @override
  bool get isEmpty => _values.isEmpty;

  @override
  bool get isNotEmpty => _values.isNotEmpty;

  @override
  int get length => _values.length;

  /// First [V] item.
  V get first => _values.first;

  /// Last [V] item.
  V get last => _values.last;

  /// Returns stream of record of changes of this [SortedObsMap].
  Stream<MapChangeNotification<K, V>> get changes => _keys.changes;

  @override
  operator []=(K key, V value) {
    _values.remove(_keys[key]);

    _values.add(value);
    _keys[key] = value;
  }

  @override
  V? operator [](Object? key) => _keys[key];

  @override
  V? remove(Object? key) {
    V? removed = _keys.remove(key);
    _values.remove(removed);

    return removed;
  }

  @override
  void clear() {
    _keys.clear();
    _values.clear();
  }

  /// Returns a [Comparator] for the provided [V].
  static Comparator<V> _defaultCompare<V>() {
    // If [V] is [Comparable], then just return it.
    Object compare = Comparable.compare;
    if (compare is Comparator<V>) {
      return compare;
    }

    return (_, __) => -1;
  }
}
