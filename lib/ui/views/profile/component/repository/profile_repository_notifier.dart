import 'package:skybase/config/base/base_notifier.dart';
import 'package:skybase/data/models/repo/repo.dart';
import 'package:skybase/data/repositories/auth/auth_repository.dart';

class ProfileRepositoryNotifier extends BaseNotifier<Repo> {
  final AuthRepository repository;

  ProfileRepositoryNotifier(this.repository);

  @override
  void onReady() {
    loadData(() => onGetRepository());
    super.onReady();
  }

  Future<void> onGetRepository() async {
    showLoading();
    try {
      final response = await repository.getProfileRepository(
        requestParams: requestParams,
        username: 'nandakista',
      );
      loadFinish(list: response);
    } catch (e) {
      loadError(e.toString());
    }
  }

}