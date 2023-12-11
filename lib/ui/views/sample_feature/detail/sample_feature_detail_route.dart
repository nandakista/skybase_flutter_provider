import 'package:go_router/go_router.dart';
import 'package:skybase/ui/views/sample_feature/detail/sample_feature_detail_view.dart';

import 'sample_feature_detail_binding.dart';

final sampleFeatureDetailPage = [
  GoRoute(
    path: SampleFeatureDetailView.route,
    name: SampleFeatureDetailView.route,
    builder: SampleFeatureBinding().builder(),
  ),
];
