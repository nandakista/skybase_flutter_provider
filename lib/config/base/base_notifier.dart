/* Created by
   Varcant
   nanda.kista@gmail.com
*/

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:skybase/config/base/connectivity_mixin.dart';
import 'package:skybase/core/database/storage/storage_manager.dart';
import 'package:skybase/core/extension/string_extension.dart';

enum RequestState { initial, empty, loading, success, error, shimmering }

extension RequestStateExt on RequestState {
  bool get isInitial => this == RequestState.initial;
  bool get isEmpty => this == RequestState.empty;
  bool get isLoading => this == RequestState.loading;
  bool get isSuccess => this == RequestState.success;
  bool get isError => this == RequestState.error;
  bool get isShimmering => this == RequestState.shimmering;
}

abstract class BaseNotifier<T> extends ChangeNotifier with ConnectivityMixin {
  StorageManager storage = StorageManager.instance;

  CancelToken cancelToken = CancelToken();
  String? errorMessage;

  RequestState state = RequestState.initial;

  int perPage = 20;
  int page = 1;

  T? dataObj;
  List<T> dataList = [];

  bool get isInitial => state.isInitial;

  bool get isLoading => state.isLoading;

  bool get isShimmering => isLoading && !isEmpty;

  bool get isError => errorMessage.isNotNullAndNotEmpty && state.isError;

  bool get isEmpty => state.isEmpty;

  bool get isSuccess => !isEmpty && !isError && !isLoading && state.isSuccess;

  @mustCallSuper
  void onInit([dynamic args]) {
    listenConnectivity(() {
      if (isError && !isLoading) onRefresh();
    });
  }

  void onRefresh([BuildContext? context]) {}

  Future<void> deleteCached(String cacheKey, {String? cacheId}) async {
    if (cacheId != null) {
      await storage.delete('$cacheKey/$cacheId');
    } else {
      await storage.delete(cacheKey.toString());
    }
  }

  void showLoading() {
    errorMessage = null;
    state = RequestState.loading;
    notifyListeners();
  }

  void showError(String message) {
    errorMessage = message;
    state = RequestState.error;
    notifyListeners();
  }

  void loadData(Function() onLoad) {
    onLoad();
  }

  /// **NOTE:**
  /// call this [finishLoadData] instead [saveCacheAndFinish] if the data
  /// is not require to saved in local data
  finishLoadData({
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
