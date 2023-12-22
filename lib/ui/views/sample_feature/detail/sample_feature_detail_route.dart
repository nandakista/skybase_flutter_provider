import 'package:skybase/config/base/route_page.dart';
import 'package:skybase/ui/views/sample_feature/detail/sample_feature_detail_view.dart';

import 'sample_feature_detail_binding.dart';

final sampleFeatureDetailPage = [
  RoutePage(
    name: SampleFeatureDetailView.route,
    page: (args) => SampleFeatureDetailView(usernameArgs: args['username'] as String),
    binding: SampleFeatureDetailBinding(),
  ),
];
