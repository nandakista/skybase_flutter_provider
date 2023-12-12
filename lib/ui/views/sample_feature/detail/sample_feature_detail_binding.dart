import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:skybase/config/base/bindings.dart';
import 'package:skybase/service_locator.dart';

import 'sample_feature_detail_notifier.dart';
import 'sample_feature_detail_view.dart';

class SampleFeatureBinding extends Bindings {
  @override
  List<SingleChildWidget> dependencies(
    BuildContext context,
    Map<String, dynamic> args,
  ) {
    return [
      ChangeNotifierProvider(
        create: (_) => sl<SampleFeatureDetailNotifier>()..onInit(args),
      ),
    ];
  }

  @override
  Widget page(BuildContext context, Map<String, dynamic> args) {
    return SampleFeatureDetailView(usernameArgs: args['username'] as String);
  }
}
