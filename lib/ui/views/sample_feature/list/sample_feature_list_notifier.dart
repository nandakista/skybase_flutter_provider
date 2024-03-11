import 'package:flutter/cupertino.dart';
import 'package:skybase/config/base/main_navigation.dart';
import 'package:skybase/config/base/pagination_notifier.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/data/repositories/sample_feature/sample_feature_repository.dart';
import 'package:skybase/data/sources/local/cached_key.dart';
import 'package:skybase/ui/views/sample_feature/detail/sample_feature_detail_view.dart';

class SampleFeatureListNotifier extends PaginationNotifier<SampleFeature> {
  final SampleFeatureRepository repository;

  SampleFeatureListNotifier(this.repository);

  @override
  void onReady() {
    loadData(() => onGetUsers());
    super.onReady();
  }

  @override
  bool get keepAlive => true;

  @override
  String get cachedKey => CachedKey.SAMPLE_FEATURE_LIST;

  Future<void> onGetUsers() async {
    try {
      final response = await repository.getUsers(
        requestParams: requestParams,
        page: page,
        perPage: perPage,
      );
      loadNextData(data: response);
    } catch (e) {
      debugPrint('Error : $e');
      loadError(e.toString());
    }
  }

  void onChooseUser({
    required BuildContext context,
    required int id,
    required String username,
  }) {
    Navigation.instance.push(
      context,
      SampleFeatureDetailView.route,
      arguments: {
        'id': id,
        'username': username,
      },
    );
  }
}
