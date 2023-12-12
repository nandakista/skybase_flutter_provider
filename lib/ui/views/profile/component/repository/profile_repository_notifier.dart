import 'package:flutter/material.dart';
import 'package:skybase/config/base/base_notifier.dart';
import 'package:skybase/data/models/repo/repo.dart';
import 'package:skybase/data/repositories/auth/auth_repository.dart';

class ProfileRepositoryNotifier extends BaseNotifier<Repo> {
  final AuthRepository repository;

  ProfileRepositoryNotifier(this.repository);

  @override
  void onInit([Map<String, dynamic>? args]) {
    loadData(() => onGetRepository());
    super.onInit(args);
  }

  @override
  Future<void> onRefresh([BuildContext? context]) async {
    super.onRefresh(context);
    await onGetRepository();
  }

  Future<void> onGetRepository() async {
    showLoading();
    try {
      final response = await repository.getProfileRepository(
        cancelToken: cancelToken,
        username: 'nandakista',
      );
      finishLoadData(list: response);
    } catch (e) {
      showError(e.toString());
    }
  }

}