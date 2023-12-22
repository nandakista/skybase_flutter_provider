import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:skybase/config/base/route_binding.dart';
import 'package:skybase/service_locator.dart';
import 'package:skybase/ui/views/intro/intro_notifier.dart';

class IntroBinding extends Binding {
  @override
  List<SingleChildWidget> dependencies(args ) {
    return [
      ChangeNotifierProvider(create: (_) => sl<IntroNotifier>()),
    ];
  }
}