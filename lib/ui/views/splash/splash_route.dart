import 'package:skybase/config/base/route_page.dart';
import 'package:skybase/ui/views/splash/splash_view.dart';

final splashRoute = [
  RoutePage(
    name: SplashView.route,
    page: (args) => const SplashView(),
  ),
];
