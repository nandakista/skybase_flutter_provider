import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skybase/config/themes/app_colors.dart';
import 'package:skybase/ui/views/intro/intro_data.dart';
import 'package:skybase/ui/views/intro/intro_notifier.dart';
import 'package:skybase/ui/views/intro/widgets/intro_indicator.dart';

import 'widgets/intro_content.dart';

class IntroView extends StatelessWidget {
  static const String route = '/intro';

  const IntroView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: kToolbarHeight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Consumer<IntroNotifier>(
                builder: (context, notifier, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      (notifier.isFirstPage)
                          ? const SizedBox.shrink()
                          : InkWell(
                              onTap: () =>
                                  notifier.pageController.jumpToPage(2),
                              child: const Icon(Icons.arrow_back),
                            ),
                      notifier.isLastPage
                          ? const SizedBox.shrink()
                          : GestureDetector(
                              onTap: () =>
                                  notifier.pageController.jumpToPage(2),
                              child: const Text(
                                "Lewati",
                                style: TextStyle(color: AppColors.primary),
                              ),
                            ),
                    ],
                  );
                },
              ),
            ),
            Expanded(
              child: PageView.builder(
                itemCount: introItem.length,
                controller: context.read<IntroNotifier>().pageController,
                itemBuilder: (context, index) {
                  final item = introItem[index];
                  return IntroContent(
                    image: item.image,
                    title: item.tittle,
                    description: item.description,
                  );
                },
                onPageChanged: (index) {
                  context.read<IntroNotifier>().onChangePage(index);
                },
              ),
            ),
            const SizedBox(height: 46),
            SizedBox(
              height: kBottomNavigationBarHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 40,
                    child: Consumer<IntroNotifier>(
                        builder: (context, notifier, _) {
                      return Visibility(
                        visible: !notifier.isFirstPage,
                        child: InkWell(
                          onTap: () => notifier.onPreviousPage(),
                          child: const Icon(
                            Icons.arrow_back,
                            color: AppColors.primary,
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(width: 48),
                  Selector<IntroNotifier, int>(
                      selector: (_, notifier) => notifier.currentIndex,
                      builder: (context, currentIndex, child) {
                        return IntroIndicator(
                          itemCount: introItem.length,
                          currentIndex: currentIndex,
                        );
                      }),
                  const SizedBox(width: 48),
                  Consumer<IntroNotifier>(builder: (context, notifier, _) {
                    return SizedBox(
                      width: 40,
                      child: Visibility(
                        visible: notifier.isLastPage,
                        child: GestureDetector(
                          onTap: () => notifier.onNextPage(context),
                          child: const Text(
                            "Done",
                            style: TextStyle(color: AppColors.primary),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 46),
          ],
        ),
      ),
    );
  }
}
