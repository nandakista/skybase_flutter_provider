import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:skybase/service_locator.dart';
import 'package:skybase/ui/views/profile/profile_notifier.dart';
import 'package:skybase/ui/views/profile/profile_view.dart';

import 'component/repository/profile_repository_notifier.dart';

final profileRoute = [
  GoRoute(
    path: ProfileView.route,
    name: ProfileView.route,
    builder: (context, state) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => sl<ProfileNotifier>()..onInit(),
          ),
          ChangeNotifierProvider(
            create: (_) => sl<ProfileRepositoryNotifier>()..onInit(),
          ),
        ],
        child: const ProfileView(),
      );
    }
  ),
];
