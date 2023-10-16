import 'package:flutter/cupertino.dart';
import 'package:skybase/config/base/main_navigation.dart';
import 'package:skybase/core/database/storage/storage_key.dart';
import 'package:skybase/core/database/storage/storage_manager.dart';
import 'package:skybase/ui/views/login/login_view.dart';

class IntroNotifier extends ChangeNotifier {
  int currentIndex = 0;
  PageController pageController = PageController(initialPage: 0);

  bool get isFirstPage => currentIndex == 0;

  bool get isLastPage => currentIndex == 2;

  void onChangePage(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void onPreviousPage() {
    pageController.previousPage(
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 260),
    );
  }

  void onNextPage(BuildContext context) {
    if (!isLastPage) {
      pageController.nextPage(
        curve: Curves.easeIn,
        duration: const Duration(milliseconds: 260),
      );
    } else {
      StorageManager.instance.save(StorageKey.FIRST_INSTALL, false);
      MainNavigation.push(context, LoginView.route);
    }
  }
}
