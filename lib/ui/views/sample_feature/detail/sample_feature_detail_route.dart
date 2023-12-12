import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:skybase/service_locator.dart';
import 'package:skybase/ui/views/sample_feature/detail/sample_feature_detail_view.dart';

import 'sample_feature_detail_notifier.dart';

final sampleFeatureDetailPage = [
  GoRoute(
    path: SampleFeatureDetailView.route,
    name: SampleFeatureDetailView.route,
    builder: (context, state) {
      final extra = state.extra as Map<String, dynamic>;
      return ChangeNotifierProvider<SampleFeatureDetailNotifier>(
        create: (_) => sl<SampleFeatureDetailNotifier>()..onInit(extra),
        child: SampleFeatureDetailView(
          usernameArgs: extra['username'] as String,
        ),
      );
    },
  ),
];
