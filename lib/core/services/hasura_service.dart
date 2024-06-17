import 'package:flutter/foundation.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:shared_preferences_cache_interceptor/shared_preferences_cache_interceptor.dart';

import '../utils/constants.dart';


HasuraConnect createHasuraConnect() {
  final cacheInterceptor = SharedPreferencesCacheInterceptor();
  return HasuraConnect(
    baseUrl,
    headers: header,
    interceptors: [ TokenInterceptor()],
  );
}


/// TOKEN INTERCENPTOR
class TokenInterceptor extends InterceptorBase {
  @override
  Future? onRequest(Request request, HasuraConnect connect) async {
    return request;
  }

  @override
  Future? onResponse(Response data, HasuraConnect connect) async {
    debugPrint(data.toString(), wrapWidth: 9999);
    return data;
  }

  @override
  Future? onError(HasuraError error, HasuraConnect connect) {
    // TODO: implement onError
    return super.onError(error, connect);
  }
}

