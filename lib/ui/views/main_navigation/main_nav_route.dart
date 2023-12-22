import 'package:skybase/config/base/route_page.dart';
import 'package:skybase/ui/views/main_navigation/main_nav_binding.dart';
import 'package:skybase/ui/views/main_navigation/main_nav_view.dart';

final mainNavRoute = [
  RoutePage(
    name: MainNavView.route,
    page: (args) => const MainNavView(),
    binding: MainNavBinding(),
  ),
];
