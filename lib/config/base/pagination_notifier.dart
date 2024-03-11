/* Created by
   Varcant
   nanda.kista@gmail.com
*/

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:skybase/core/mixin/cache_mixin.dart';
import 'package:skybase/core/mixin/connectivity_mixin.dart';

import 'request_param.dart';

abstract class PaginationNotifier<T> extends ChangeNotifier
    with ConnectivityMixin, CacheMixin {
  late RequestParams requestParams;

  CancelToken cancelToken = CancelToken();
  int perPage = 20;
  int page = 1;
  final pagingController = PagingController<int, T>(firstPageKey: 1);

  bool get keepAlive => false;

  String get cachedKey => '';

  Future Function()? _onLoad;

  @mustCallSuper
  void onInit([dynamic args]) {
    requestParams = RequestParams(
      cancelToken: cancelToken,
      cachedKey: cachedKey,
    );
    listenConnectivity(() {
      if (pagingController.value.status == PagingStatus.firstPageError) {
        onRefresh();
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => onReady());
  }

  /// Called 1 frame after onInit(). It is the perfect place to enter
  /// navigation events, like snackbar, dialogs, or a new route, or
  /// async request.
  void onReady() {}

  @mustCallSuper
  void onRefresh([BuildContext? context]) async {
    if (_onLoad != null) {
      page = 1;
      if (cachedKey.isNotEmpty) {
        await deleteCached(cachedKey);
      }
      pagingController.value = PagingState(
        nextPageKey: page,
        error: null,
        itemList: keepAlive ? _keepAliveData : null,
      );
      await _onLoad!();
      notifyListeners();
    }
  }

  void loadData(Future Function() onLoad) async {
    pagingController.addPageRequestListener((page) async {
      if (page > 1) await onLoad();
    });
    if (page == 1) await onLoad();
    this._onLoad = onLoad;
  }

  void loadError(String message) {
    pagingController.error = message;
  }

  void loadNextData({required List<T> data}) {
    final isLastPage = data.length < perPage;
    if (isLastPage) {
      pagingController.appendLastPage(data);
    } else {
      if (page == 1 && (pagingController.itemList ?? []).isNotEmpty) {
        pagingController.itemList?.clear();
      }
      this.page++;
      pagingController.appendPage(data, page);
    }
  }

  List<T> get _keepAliveData {
    List<T> dataList = pagingController.itemList ?? [];
    if (dataList.length >= perPage) {
      return dataList.sublist(0, perPage);
    } else {
      return dataList;
    }
  }

  @override
  @mustCallSuper
  void dispose() {
    cancelConnectivity();
    pagingController.dispose();
    cancelToken.cancel();
    super.dispose();
  }
}
