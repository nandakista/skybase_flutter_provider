import 'package:skybase/config/base/base_notifier.dart';
import 'package:skybase/data/models/sample_feature/sample_feature.dart';
import 'package:skybase/data/repositories/sample_feature/sample_feature_repository.dart';
import 'package:skybase/data/sources/local/cached_key.dart';

class SampleFeatureDetailNotifier extends BaseNotifier<SampleFeature> {
  final SampleFeatureRepository repository;

  SampleFeatureDetailNotifier(this.repository);

  late int idArgs;
  late String usernameArgs;

  SampleFeatureDetailNotifier onInit({
    required int id,
    required String username,
  }) {
    idArgs = id;
    usernameArgs = username;
    loadData(() => onGetDetailUser());
    return this;
  }

  Future<void> onRefresh() async {
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
