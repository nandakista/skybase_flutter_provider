import 'package:skybase/config/base/route_page.dart';
import 'package:skybase/ui/views/login/login_view.dart';

import 'login_binding.dart';

final loginRoute = [
  RoutePage(
    name: LoginView.route,
    page: (args) => const LoginView(),
    binding: LoginBinding(),
  ),
];
