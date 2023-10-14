import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:skybase/ui/widgets/sky_button.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class EmptyView extends StatelessWidget {
  const EmptyView({
    Key? key,
    this.emptyImage,
    this.emptyImageWidget,
    this.emptyTitle,
    this.emptySubtitle,
    this.physics,
    this.imageSize,
    this.verticalSpacing = 24,
    this.horizontalSpacing = 24,
    this.titleStyle,
    this.subtitleStyle,
    this.retryText,
    this.onRetry,
    this.retryWidget,
    this.emptyRetryEnabled = false,
  }) : super(key: key);

  final Widget? emptyImageWidget;
  final String? emptyImage;
  final String? emptyTitle;
  final String? emptySubtitle;
  final ScrollPhysics? physics;
  final double? imageSize;
  final double verticalSpacing;
  final double horizontalSpacing;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final String? retryText;
  final VoidCallback? onRetry;
  final Widget? retryWidget;
  final bool emptyRetryEnabled;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: verticalSpacing,
          horizontal: horizontalSpacing,
        ),
        physics: physics,
        child: Column(
          children: [
            emptyImageWidget ??
                Image.asset(
                  emptyImage ?? 'assets/images/img_empty.png',
                  height: imageSize,
                ),
            SizedBox(height: verticalSpacing),
            Text(
              emptyTitle ?? 'txt_empty_list_title'.tr(),
              textAlign: TextAlign.center,
              style: titleStyle ?? Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(height: verticalSpacing / 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                emptySubtitle ?? 'txt_empty_list_subtitle'.tr(),
                textAlign: TextAlign.center,
                style: subtitleStyle,
              ),
            ),
            SizedBox(height: verticalSpacing),
            if (emptyRetryEnabled && onRetry != null)
              retryWidget ??
                  SkyButton(
                    wrapContent: true,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    text: retryText ?? 'txt_reload'.tr(),
                    onPressed: onRetry,
                  )
          ],
        ),
      ),
    );
  }
}
