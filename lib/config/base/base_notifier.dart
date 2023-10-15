import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:skybase/core/database/storage/storage_manager.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
enum RequestState { initial, empty, loading, success, error }

extension RequestStateExt on RequestState {
  bool get isInitial => this == RequestState.initial;
  bool get isEmpty => this == RequestState.empty;
  bool get isLoading => this == RequestState.loading;
  bool get isSuccess => this == RequestState.success;
  bool get isError => this == RequestState.error;
}

abstract class BaseNotifier<T> extends ChangeNotifier {
  StorageManager storage = StorageManager.find;

  CancelToken cancelToken = CancelToken();
  String errorMessage = '';

  RequestState state = RequestState.initial;

  int perPage = 20;
  int page = 1;

  T? dataObj;
  List<T> dataList = [];

  bool get isInitial => state.isInitial;

  bool get isLoading => state.isLoading;

  bool get isError => errorMessage.isNotEmpty && state.isError;

  bool get isEmpty => dataList.isEmpty && dataObj == null && state.isEmpty;

  bool get isSuccess => !isEmpty && !isError && !isLoading;

  void showLoading() {
    errorMessage = '';
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
    state = RequestState.success;
    notifyListeners();
  }

  @override
  void dispose() {
    cancelToken.cancel();
    super.dispose();
  }
}
