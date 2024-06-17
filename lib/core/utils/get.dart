
import 'package:get/get.dart';

/// Extension adding ability to find non-strict dependencies from a
/// [GetInterface].
extension GetExtension on GetInterface {
  /// Returns the [S] dependency, if it [Inst.isRegistered].
  S? findOrNull<S>({String? tag}) {
    if (isRegistered<S>(tag: tag)) {
      return find<S>(tag: tag);
    }

    return null;
  }

  /// Puts the [dependency], if it isn't [Inst.isRegistered].
  S putOrGet<S>(
    S Function() dependency, {
    String? tag,
    bool permanent = false,
  }) {
    if (isRegistered<S>(tag: tag)) {
      return find<S>(tag: tag);
    }

    return put<S>(dependency(), tag: tag, permanent: permanent);
  }
}
