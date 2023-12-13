import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:skybase/config/base/bindings.dart';
import 'package:skybase/service_locator.dart';
import 'package:skybase/ui/views/profile/profile_notifier.dart';

import 'component/repository/profile_repository_notifier.dart';
import 'profile_view.dart';

class ProfileBinding extends Bindings {
  @override
  List<SingleChildWidget> dependencies(BuildContext context, dynamic args) {
    return [
      ChangeNotifierProvider(
        create: (_) => sl<ProfileNotifier>()..onInit(),
      ),
      ChangeNotifierProvider(
        create: (_) => sl<ProfileRepositoryNotifier>()..onInit(),
      ),
    ];
  }

  @override
  Widget page(BuildContext context, dynamic args) {
    return const ProfileView();
  }
}