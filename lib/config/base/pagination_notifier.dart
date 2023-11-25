import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:skybase/core/database/storage/storage_manager.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
abstract class PaginationNotifier<T> extends ChangeNotifier {
  StorageManager storage = StorageManager.instance;

  CancelToken cancelToken = CancelToken();
  int perPage = 20;
  int page = 1;
  final pagingController = PagingController<int, T>(firstPageKey: 0);

  @mustCallSuper
  void onRefresh() {
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
    // notifyListeners();
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
    pagingController.dispose();
    cancelToken.cancel();
    super.dispose();
  }
}
