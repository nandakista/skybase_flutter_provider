import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:skybase/service_locator.dart';
import 'package:skybase/ui/views/settings/setting_notifier.dart';
import 'package:skybase/ui/views/settings/setting_view.dart';

final settingRoute = [
  GoRoute(
    path: SettingView.route,
    name: SettingView.route,
    builder: (context, state) => ChangeNotifierProvider(
      create: (_) => sl<SettingNotifier>(),
      child: const SettingView(),
    ),
  ),
];
