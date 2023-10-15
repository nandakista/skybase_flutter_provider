import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:skybase/service_locator.dart';
import 'package:skybase/ui/views/login/login_notifier.dart';
import 'package:skybase/ui/views/login/login_view.dart';

final loginRoute = [
  GoRoute(
    path: LoginView.route,
    name: LoginView.route,
    builder: (context, state) => ChangeNotifierProvider(
      create: (_) => sl<LoginNotifier>(),
      child: const LoginView(),
    ),
  ),
];
