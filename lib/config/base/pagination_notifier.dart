/* Created by
   Varcant
   nanda.kista@gmail.com
*/

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:skybase/config/base/connectivity_mixin.dart';
import 'package:skybase/core/database/storage/storage_manager.dart';

abstract class PaginationNotifier<T> extends ChangeNotifier with ConnectivityMixin {
  StorageManager storage = StorageManager.instance;

  CancelToken cancelToken = CancelToken();
  int perPage = 20;
  int page = 1;
  final pagingController = PagingController<int, T>(firstPageKey: 0);

  @mustCallSuper
  void onInit([dynamic args]) {
    listenConnectivity(() {
      if (pagingController.value.status == PagingStatus.firstPageError) {
        onRefresh();
      }
    });
  }

  @mustCallSuper
  void onRefresh([BuildContext? context]) {
    page = 1;
    pagingController.refresh();
    notifyListeners();
  }

  Future<void> deleteCached(String cacheKey) async {
    await storage.delete(cacheKey.toString());
  }

  void loadData(Function() onLoad) {
    pagingController.addPageRequestListener((page) => onLoad());
  }

  void showError(String message) {
    pagingController.error = message;
  }

  void loadNextData({required List<T> data, int? page}) {
    final isLastPage = data.length < perPage;
    if (isLastPage) {
      pagingController.appendLastPage(data);
    } else {
      pagingController.appendPage(data, page ?? this.page++);
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
