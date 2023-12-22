import 'package:skybase/config/base/route_page.dart';
import 'package:skybase/ui/views/profile/profile_binding.dart';
import 'package:skybase/ui/views/profile/profile_view.dart';

final profileRoute = [
  RoutePage(
    name: ProfileView.route,
    page: (args) => const ProfileView(),
    binding: ProfileBinding(),
  ),
];
