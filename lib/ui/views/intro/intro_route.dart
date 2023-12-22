import 'package:skybase/config/base/route_page.dart';
import 'package:skybase/ui/views/intro/intro_view.dart';

import 'intro_binding.dart';

final introRoute = [
  RoutePage(
    name: IntroView.route,
    page: (args) => const IntroView(),
    binding: IntroBinding(),
  ),
];
