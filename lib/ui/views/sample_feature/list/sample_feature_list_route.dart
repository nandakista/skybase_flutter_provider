import 'package:go_router/go_router.dart';
import 'package:skybase/ui/views/sample_feature/list/sample_feature_list_binding.dart';
import 'package:skybase/ui/views/sample_feature/list/sample_feature_list_view.dart';

final sampleFeatureRoute = [
  GoRoute(
    path: SampleFeatureListView.route,
    name: SampleFeatureListView.route,
    builder: SampleFeatureListBinding().builder(),
  ),
];
