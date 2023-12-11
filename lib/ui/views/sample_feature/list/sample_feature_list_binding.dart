import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:skybase/config/base/bindings.dart';
import 'package:skybase/service_locator.dart';

import 'sample_feature_list_notifier.dart';
import 'sample_feature_list_view.dart';

class SampleFeatureListBinding extends Bindings {
  @override
  List<SingleChildWidget> dependencies(
    BuildContext context,
    Map<String, dynamic> args,
  ) {
    return [
      ChangeNotifierProvider(
        create: (_) => sl<SampleFeatureListNotifier>()..onInit(),
      ),
    ];
  }

  @override
  Widget page(BuildContext context, Map<String, dynamic> args) {
    return const SampleFeatureListView();
  }
}
