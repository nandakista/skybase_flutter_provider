import 'package:flutter/material.dart';
import 'package:skybase/config/base/base_notifier.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/data/repositories/sample_feature/sample_feature_repository.dart';
import 'package:skybase/data/sources/local/cached_key.dart';

class SampleFeatureDetailNotifier extends BaseNotifier<SampleFeature> {
  final SampleFeatureRepository repository;

  SampleFeatureDetailNotifier(this.repository);

  late int idArgs;
  late String usernameArgs;

  @override
  void onInit([dynamic args]) {
    idArgs = args?['id'];
    usernameArgs = args?['username'];
    loadData(() => onGetDetailUser());
    super.onInit(args);
  }

  @override
  Future<void> onRefresh([BuildContext? context]) async {
    await deleteCached(
      CachedKey.SAMPLE_FEATURE_DETAIL,
      cacheId: idArgs.toString(),
    );
    await onGetDetailUser();
  }

  Future<void> onGetDetailUser() async {
    showLoading();
    try {
      final response = await repository.getDetailUser(
        cancelToken: cancelToken,
        id: idArgs,
        username: usernameArgs,
      );
      finishLoadData(data: response);
    } catch (e) {
      showError(e.toString());
    }
  }
}
