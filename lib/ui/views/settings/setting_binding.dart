import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:skybase/config/base/route_binding.dart';
import 'package:skybase/service_locator.dart';
import 'package:skybase/ui/views/settings/setting_notifier.dart';

class SettingBinding extends Binding {
  @override
  List<SingleChildWidget> dependencies(args) {
    return [
      ChangeNotifierProvider(create: (_) => sl<SettingNotifier>()),
    ];
  }
}
