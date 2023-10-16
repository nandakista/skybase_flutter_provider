import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skybase/config/themes/theme_manager.dart';
import 'package:skybase/core/localization/locale_manager.dart';

import 'app_configuration.dart';
import 'config/themes/app_theme.dart';
import 'service_locator.dart';
import 'ui/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await ServiceLocator.init();
  runApp(
    EasyLocalization(
      path: 'lib/core/localization/languages',
      supportedLocales: LocaleManager.find.locales.values.toList(),
      startLocale: LocaleManager.find.getCurrentLocale,
      fallbackLocale: LocaleManager.find.fallbackLocale,
      useFallbackTranslations: true,
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeManager.find),
      ],
      child: Selector<ThemeManager, bool>(
        selector: (context, state) => state.isDark,
        builder: (context, isDarkMode, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: AppConfiguration.appName,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: (isDarkMode) ? ThemeMode.dark : ThemeMode.light,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            routeInformationParser: AppRoutes.router.routeInformationParser,
            routeInformationProvider: AppRoutes.router.routeInformationProvider,
            routerDelegate: AppRoutes.router.routerDelegate,
          );
        },
      ),
    );
  }
}
