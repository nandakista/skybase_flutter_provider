import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';
import 'package:skybase/config/base/bindings.dart';
import 'package:skybase/ui/views/profile/profile_binding.dart';
import 'package:skybase/ui/views/sample_feature/list/sample_feature_list_binding.dart';

import 'main_nav_view.dart';

class MainNavBinding extends Bindings {
  @override
  List<SingleChildWidget> dependencies(BuildContext context, dynamic args) {
    return [
      ...SampleFeatureListBinding().dependencies(context, args),
      ...ProfileBinding().dependencies(context, args),
    ];
  }

  @override
  Widget page(BuildContext context, dynamic args) {
    return const MainNavView();
  }
}
