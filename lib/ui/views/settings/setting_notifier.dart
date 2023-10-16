import 'package:flutter/cupertino.dart';
import 'package:skybase/config/auth_manager/auth_manager.dart';
import 'package:skybase/core/database/storage/storage_key.dart';
import 'package:skybase/core/database/storage/storage_manager.dart';
import 'package:skybase/core/helper/dialog_helper.dart';
import 'package:skybase/core/localization/locale_manager.dart';

class SettingNotifier extends ChangeNotifier {
  late String languageCode;

  SettingNotifier() {
    languageCode = LocaleManager.find.getCurrentLocale.languageCode;
  }

  void onUpdateLocale(BuildContext context, {required String languageCode}) {
    this.languageCode = languageCode;
    StorageManager.find.save<String>(StorageKey.CURRENT_LOCALE, languageCode);
    LocaleManager.find.updateLocale(context, Locale(languageCode));
  }

  void onLogout(BuildContext context) async {
    LoadingDialog.show(context);
    AuthManager.find.logout();
  }
}