import 'package:flutter/foundation.dart';
import 'package:skybase/core/database/storage/storage_key.dart';
import 'package:skybase/core/database/storage/storage_manager.dart';
import 'package:skybase/service_locator.dart';

class ThemeManager extends ChangeNotifier {
  static ThemeManager get find => sl<ThemeManager>();

  bool isDark = false;
  void toDarkMode() => isDark = true;
  void toLightMode() => isDark = false;

  ThemeManager() {
    isDark = StorageManager.find.get<bool?>(StorageKey.IS_DARK_THEME) ?? false;
    notifyListeners();
  }

  Future<bool> changeTheme() async {
    isDark = !isDark;
    StorageManager.find.save<bool>(StorageKey.IS_DARK_THEME, isDark);
    notifyListeners();
    return isDark;
  }
}