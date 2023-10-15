import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skybase/config/auth_manager/auth_manager.dart';
import 'package:skybase/core/localization/locale_manager.dart';
import 'package:skybase/data/repositories/auth/auth_repository.dart';
import 'package:skybase/data/repositories/auth/auth_repository_impl.dart';
import 'package:skybase/data/repositories/sample_feature/sample_feature_repository_impl.dart';
import 'package:skybase/data/sources/server/auth/auth_sources.dart';
import 'package:skybase/data/sources/server/auth/auth_sources_impl.dart';
import 'package:skybase/data/sources/server/sample_feature/sample_feature_sources.dart';
import 'package:skybase/ui/views/intro/intro_notifier.dart';
import 'package:skybase/ui/views/login/login_notifier.dart';
import 'package:skybase/ui/views/profile/component/repository/profile_repository_notifier.dart';
import 'package:skybase/ui/views/profile/profile_notifier.dart';
import 'package:skybase/ui/views/sample_feature/list/sample_feature_list_notifier.dart';
import 'package:skybase/ui/views/settings/setting_notifier.dart';

import 'config/network/api_config.dart';
import 'config/themes/app_theme.dart';
import 'config/themes/theme_manager.dart';
import 'config/app/app_info.dart';
import 'core/database/storage/storage_manager.dart';
import 'core/database/secure_storage/secure_storage_manager.dart';
import 'data/repositories/sample_feature/sample_feature_repository.dart';
import 'data/sources/server/sample_feature/sample_feature_sources_impl.dart';
import 'ui/views/sample_feature/detail/sample_feature_detail_notifier.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/

final sl = GetIt.instance;

class ServiceLocator {
  static Future<void> init() async {
    if (kReleaseMode) debugPrint = (String? message, {int? wrapWidth}) {};
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    AppTheme.setStatusBar(brightness: Brightness.light);
    AppInfo.setInfo(await PackageInfo.fromPlatform());

    // _initConfig
    sl.registerSingleton(const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    ));
    sl.registerLazySingleton(() => Dio());
    sl.registerLazySingleton(() => DioClient()..init());
    sl.registerSingleton<SharedPreferences>(sharedPreferences);

    // _initService
    sl.registerLazySingleton(() => SecureStorageManager());
    sl.registerSingleton(StorageManager());
    sl.registerSingleton(LocaleManager());
    sl.registerFactory(() => AuthManager());
    sl.registerFactory(() => ThemeManager());

    // Repository
    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(apiService: sl<AuthSources>()),
    );
    sl.registerLazySingleton<SampleFeatureRepository>(
      () => SampleFeatureRepositoryImpl(apiService: sl<SampleFeatureSources>()),
    );

    // Sources
    sl.registerLazySingleton<AuthSources>(() => AuthSourcesImpl());
    sl.registerLazySingleton<SampleFeatureSources>(
      () => SampleFeatureSourcesImpl(),
    );

    // Provider
    sl.registerFactory(() => LoginNotifier(sl<AuthRepository>()));
    sl.registerFactory(() => IntroNotifier());
    sl.registerFactory(() => SettingNotifier());
    sl.registerFactory(() => ProfileNotifier(sl<AuthRepository>()));
    sl.registerFactory(() => ProfileRepositoryNotifier(sl<AuthRepository>()));
    sl.registerFactory(
      () => SampleFeatureListNotifier(sl<SampleFeatureRepository>()),
    );
    sl.registerFactory(
      () => SampleFeatureDetailNotifier(sl<SampleFeatureRepository>()),
    );
  }
}
