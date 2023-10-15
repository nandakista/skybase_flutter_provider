import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:skybase/service_locator.dart';
import 'package:skybase/ui/views/intro/intro_notifier.dart';
import 'package:skybase/ui/views/intro/intro_view.dart';

final introRoute = [
  GoRoute(
    path: IntroView.route,
    name: IntroView.route,
    builder: (context, state) => ChangeNotifierProvider(
      create: (_) => sl<IntroNotifier>(),
      child: const IntroView(),
    ),
  ),
];
