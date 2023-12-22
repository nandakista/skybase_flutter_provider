import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:skybase/config/base/route_binding.dart';
import 'package:skybase/service_locator.dart';

import 'sample_feature_list_notifier.dart';

class SampleFeatureListBinding extends Binding {
  @override
  List<SingleChildWidget> dependencies(dynamic args) {
    return [
      ChangeNotifierProvider(
        create: (_) => sl<SampleFeatureListNotifier>()..onInit(),
      ),
    ];
  }
}
