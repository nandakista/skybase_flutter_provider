import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:skybase/config/base/route_binding.dart';
import 'package:skybase/service_locator.dart';
import 'package:skybase/ui/views/profile/profile_notifier.dart';

import 'component/repository/profile_repository_notifier.dart';

class ProfileBinding extends Binding {
  @override
  List<SingleChildWidget> dependencies(dynamic args) {
    return [
      ChangeNotifierProvider(
        create: (_) => sl<ProfileNotifier>()..onInit(),
      ),
      ChangeNotifierProvider(
        create: (_) => sl<ProfileRepositoryNotifier>()..onInit(),
      ),
    ];
  }
}