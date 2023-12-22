import 'package:skybase/config/base/route_page.dart';
import 'package:skybase/ui/views/utils/component/bottom_sheet_utils_view.dart';
import 'package:skybase/ui/views/utils/component/dialog_utils_view.dart';
import 'package:skybase/ui/views/utils/component/list_utils_view.dart';
import 'package:skybase/ui/views/utils/component/media_utils_view.dart';
import 'package:skybase/ui/views/utils/component/other_utils_view.dart';
import 'package:skybase/ui/views/utils/component/snackbar_utils_view.dart';
import 'package:skybase/ui/views/utils/component/theme_component_utils_view.dart';

import 'utils_view.dart';

final utilsRoute = [
  RoutePage(
    name: UtilsView.route,
    page: (args) => const UtilsView(),
    routes: [
      RoutePage(
        name: BottomSheetUtilsView.route,
        page: (args) => const BottomSheetUtilsView(),
      ),
      RoutePage(
        name: DialogUtilsView.route,
        page: (args) => const DialogUtilsView(),
      ),
      RoutePage(
        name: ListUtilsView.route,
        page: (args) => const ListUtilsView(),
      ),
      RoutePage(
        name: MediaUtilsView.route,
        page: (args) => const MediaUtilsView(),
      ),
      RoutePage(
        name: OtherUtilsView.route,
        page: (args) => const OtherUtilsView(),
      ),
      RoutePage(
        name: SnackBarUtilsView.route,
        page: (args) => const SnackBarUtilsView(),
      ),
      RoutePage(
        name: ThemeComponentUtilsView.route,
        page: (args) => const ThemeComponentUtilsView(),
      ),
    ],
  ),
];
