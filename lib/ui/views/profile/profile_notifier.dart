import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skybase/config/base/base_notifier.dart';
import 'package:skybase/data/models/user/user.dart';
import 'package:skybase/data/repositories/auth/auth_repository.dart';
import 'package:skybase/ui/views/profile/component/repository/profile_repository_notifier.dart';

class ProfileNotifier extends BaseNotifier<User> {
  final AuthRepository repository;

  ProfileNotifier(this.repository);

  ProfileNotifier onInit() {
    loadData(() => onGetProfile());
    return this;
  }

  void onRefresh(BuildContext context) {
    onGetProfile();
    context.read<ProfileRepositoryNotifier>().onRefresh();
  }

  void onGetProfile() async {
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