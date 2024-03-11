import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:skybase/config/base/route_binding.dart';
import 'package:skybase/service_locator.dart';

import 'login_notifier.dart';

class LoginBinding extends Binding {
  @override
  List<SingleChildWidget> dependencies(args) {
    return [
      ChangeNotifierProvider(
        create: (_) => sl<LoginNotifier>()..onInit(),
      ),
    ];
  }
}
