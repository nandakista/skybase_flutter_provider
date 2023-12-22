import 'package:skybase/config/base/route_page.dart';
import 'package:skybase/ui/views/settings/setting_view.dart';

import 'setting_binding.dart';

final settingRoute = [
  RoutePage(
    name: SettingView.route,
    page: (args) => const SettingView(),
    binding: SettingBinding(),
  ),
];
