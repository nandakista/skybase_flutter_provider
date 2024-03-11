/* Created by
   Varcant
   nanda.kista@gmail.com
*/

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:skybase/config/base/request_state.dart';
import 'package:skybase/core/mixin/cache_mixin.dart';
import 'package:skybase/core/mixin/connectivity_mixin.dart';
import 'package:skybase/core/extension/string_extension.dart';

import 'request_param.dart';

abstract class BaseNotifier<T> extends ChangeNotifier
    with ConnectivityMixin, CacheMixin {
  late RequestParams requestParams;

  CancelToken cancelToken = CancelToken();
  String? errorMessage;

  RequestState state = RequestState.initial;

  int perPage = 20;
  int page = 1;

  T? dataObj;
  List<T> dataList = [];

  Future Function()? _onLoad;

  bool get keepAlive => false;

  String get cachedKey => '';

  String get cachedId => '';

  bool get isInitial => state.isInitial;

  bool get isLoading => state.isLoading;

  bool get isShimmering => isLoading && !isEmpty;

  bool get isError => errorMessage.isNotNullAndNotEmpty && state.isError;

  bool get isEmpty => state.isEmpty;

  bool get isSuccess => !isEmpty && !isError && !isLoading && state.isSuccess;

  @mustCallSuper
  void onInit([dynamic args]) {
    requestParams = RequestParams(
      cancelToken: cancelToken,
      cachedKey: cachedKey,
      cachedId: cachedId,
    );
    listenConnectivity(() {
      if (isError && !isLoading) onRefresh();
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => onReady());
  }


  /// Called 1 frame after onInit(). It is the perfect place to enter
  /// navigation events, like snackbar, dialogs, or a new route, or
  /// async request.
  @mustCallSuper
  void onReady() {}

  Future<void> onRefresh([BuildContext? context]) async {
    if (_onLoad != null) {
      if (cachedKey.isNotEmpty) await deleteCached('$cachedKey/$cachedId');
      if (!keepAlive) showLoading();
      await _onLoad!();
    }
  }

  void showLoading() {
    errorMessage = null;
    state = RequestState.loading;
    notifyListeners();
  }

  void loadError(String message) {
    errorMessage = message;
    state = RequestState.error;
    notifyListeners();
  }

  void loadData(Future Function() onLoad) async {
    showLoading();
    await onLoad();
    this._onLoad = onLoad;
  }

  loadFinish({
    T? data,
    List<T> list = const [],
  }) {
    if (data != null) dataObj = data;
    if (list.isNotEmpty) dataList = list;
    if (dataList.isEmpty && dataObj == null) {
      state = RequestState.empty;
    } else {
      state = RequestState.success;
    }
    notifyListeners();
  }

  @override
  @mustCallSuper
  void dispose() {
    onClose();
    cancelConnectivity();
    cancelToken.cancel();
    super.dispose();
  }

  @mustCallSuper
  void onClose() {}
}
