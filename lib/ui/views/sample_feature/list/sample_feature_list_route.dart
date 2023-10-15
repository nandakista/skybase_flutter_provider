import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:skybase/service_locator.dart';
import 'package:skybase/ui/views/sample_feature/list/sample_feature_list_view.dart';

import 'sample_feature_list_notifier.dart';

final sampleFeatureRoute = [
  GoRoute(
    path: SampleFeatureListView.route,
    name: SampleFeatureListView.route,
    builder: (context, state) {
      return ChangeNotifierProvider<SampleFeatureListNotifier>(
        create: (_) => sl<SampleFeatureListNotifier>()..onInit(),
        child: const SampleFeatureListView(),
      );
    },
  ),
];
