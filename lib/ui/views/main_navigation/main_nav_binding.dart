import 'package:provider/single_child_widget.dart';
import 'package:skybase/config/base/route_binding.dart';
import 'package:skybase/ui/views/profile/profile_binding.dart';
import 'package:skybase/ui/views/sample_feature/list/sample_feature_list_binding.dart';

class MainNavBinding extends Binding {
  @override
  List<SingleChildWidget> dependencies(dynamic args) {
    return [
      ...SampleFeatureListBinding().dependencies(args),
      ...ProfileBinding().dependencies(args),
    ];
  }
}
