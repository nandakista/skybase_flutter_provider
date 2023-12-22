import 'package:skybase/config/base/route_page.dart';
import 'package:skybase/ui/views/sample_feature/list/sample_feature_list_binding.dart';
import 'package:skybase/ui/views/sample_feature/list/sample_feature_list_view.dart';

final sampleFeatureRoute = [
  RoutePage(
    name: SampleFeatureListView.route,
    page: (args) => const SampleFeatureListView(),
    binding: SampleFeatureListBinding(),
  ),
];
