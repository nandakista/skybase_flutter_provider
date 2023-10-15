import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:skybase/service_locator.dart';
import 'package:skybase/ui/views/main_navigation/main_nav_view.dart';
import 'package:skybase/ui/views/profile/component/repository/profile_repository_notifier.dart';
import 'package:skybase/ui/views/profile/profile_notifier.dart';
import 'package:skybase/ui/views/sample_feature/list/sample_feature_list_notifier.dart';

final mainNavRoute = [
  GoRoute(
    path: MainNavView.route,
    name: MainNavView.route,
    builder: (context, state) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => sl<SampleFeatureListNotifier>()..onInit(),
          ),
          ChangeNotifierProvider(
            create: (_) => sl<ProfileNotifier>()..onInit(),
          ),
          ChangeNotifierProvider(
            create: (_) => sl<ProfileRepositoryNotifier>()..onInit(),
          ),
        ],
        child: const MainNavView(),
      );
    },
  ),
];
