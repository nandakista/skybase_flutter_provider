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
    super.onInit(args);
  }

  @override
  void onReady() async {
    loadData(() => onGetDetailUser());
    super.onReady();
  }

  @override
  bool get keepAlive => true;

  @override
  String get cachedKey => CachedKey.SAMPLE_FEATURE_DETAIL;

  @override
  String get cachedId => idArgs.toString();

  Future<void> onGetDetailUser() async {
    try {
      final response = await repository.getDetailUser(
        requestParams: requestParams,
        id: idArgs,
        username: usernameArgs,
      );
      loadFinish(data: response);
    } catch (e) {
      loadError(e.toString());
    }
  }
}
