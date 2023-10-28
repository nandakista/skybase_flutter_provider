import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:skybase/config/app/app_info.dart';
import 'package:skybase/config/auth_manager/auth_manager.dart';
import 'package:skybase/config/themes/app_style.dart';
import 'package:skybase/config/themes/theme_manager.dart';
import 'package:skybase/core/helper/dialog_helper.dart';
import 'package:skybase/ui/views/settings/setting_notifier.dart';
import 'package:skybase/ui/widgets/colored_status_bar.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';
import 'package:skybase/ui/widgets/sky_button.dart';

class SettingView extends StatelessWidget {
  static const String route = '/setting';

  const SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredStatusBar(
      brightness: Brightness.dark,
      child: Scaffold(
        appBar: SkyAppBar.secondary(title: 'txt_setting'.tr()),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.fromLTRB(
            24,
            12,
            24,
            MediaQuery.paddingOf(context).bottom + 12,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${'txt_version'.tr()} ${AppInfo.appVersion}',
                style: AppStyle.body2.copyWith(color: Colors.grey),
              ),
              const SizedBox(height: 12),
              SkyButton(
                onPressed: () {
                  LoadingDialog.show(context);
                  AuthManager.instance.logout();
                },
                text: 'txt_logout'.tr(),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(child: Text('txt_language'.tr())),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text('ENG'),
                        Consumer<SettingNotifier>(
                          builder: (context, notifier, child) {
                            return Radio<String>(
                              value: 'en',
                              groupValue: notifier.languageCode,
                              onChanged: (value) {
                                notifier.onUpdateLocale(
                                  context,
                                  languageCode: value.toString(),
                                );
                              },
                            );
                          },
                        ),
                        const Text('ID'),
                        Consumer<SettingNotifier>(
                            builder: (context, notifier, child) {
                              return Radio(
                                value: 'id',
                                groupValue: notifier.languageCode,
                                onChanged: (value) async {
                                  notifier.onUpdateLocale(
                                    context,
                                    languageCode: value.toString(),
                                  );
                                },
                              );
                            }
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const Divider(color: Colors.grey),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('txt_dark_mode'.tr()),
                  Consumer<ThemeManager>(
                      builder: (context, notifier, child) {
                        return Switch(
                          value: notifier.isDark,
                          onChanged: (value) {
                            notifier.changeTheme();
                          },
                        );
                      }
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
