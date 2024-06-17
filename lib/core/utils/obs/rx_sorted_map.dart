
import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import 'map.dart';
import 'sorted_map.dart';

/// `GetX`-reactive [SortedObsMap].
class RxSortedObsMap<K, V> extends MapMixin<K, V>
    with NotifyManager<SortedObsMap<K, V>>, RxObjectMixin<SortedObsMap<K, V>>
    implements RxInterface<SortedObsMap<K, V>> {
  RxSortedObsMap() : _value = SortedObsMap<K, V>();

  /// Internal actual value of the [SortedObsMap] this [RxSortedObsMap] holds.
  late final SortedObsMap<K, V> _value;

  /// Returns stream of record of changes of this [RxSortedObsMap].
  Stream<MapChangeNotification<K, V>> get changes => _value.changes;

  @override
  V? operator [](Object? key) => value[key as K?];

  @override
  void operator []=(K key, V value) {
    _value[key] = value;
    refresh();
  }

  @override
  void clear() {
    _value.clear();
    refresh();
  }

  @override
  Iterable<K> get keys => value.keys;

  @override
  Iterable<V> get values => value.values;

  @override
  V? remove(Object? key) {
    final val = _value.remove(key);
    refresh();
    return val;
  }

  @override
  @protected
  SortedObsMap<K, V> get value {
    RxInterface.proxy?.addListener(subject);
    return _value;
  }
}
