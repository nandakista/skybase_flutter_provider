import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:skybase/config/base/base_notifier.dart';
import 'package:skybase/data/models/user/user.dart';
import 'package:skybase/data/repositories/auth/auth_repository.dart';
import 'package:skybase/ui/views/profile/component/repository/profile_repository_notifier.dart';

class ProfileNotifier extends BaseNotifier<User> {
  final AuthRepository repository;

  ProfileNotifier(this.repository);

  @override
  ProfileNotifier onInit([Map<String, dynamic>? args]) {
    super.onInit(args);
    loadData(() => onGetProfile());
    return this;
  }

  @override
  Future<void> onRefresh([BuildContext? context]) async {
    await onGetProfile();
    await context?.read<ProfileRepositoryNotifier>().onRefresh();
  }

  Future<void> onGetProfile() async {
    showLoading();
    try {
      final response = await repository.getProfile(
        cancelToken: cancelToken,
        username: 'nandakista',
      );
      finishLoadData(data: response);
    } catch (e) {
      showError(e.toString());
    }
  }
}
