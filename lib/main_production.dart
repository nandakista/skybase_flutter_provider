import 'package:skybase/dev/dev_token.dart';

import './main.dart' as main_app;
import 'config/environment/app_env.dart';
import 'config/environment/config_data.dart';
import 'config/network/api_token_manager.dart';

void main() async {
  /// TODO: To test this repository you can change this clientToken to Github token
  /// You can get github token with : Profile > Settings > Developer Settings > Personal access tokens
  AppEnv.set(
    environment: Environment.PRODUCTION,
    configuration: ConfigData(
      baseUrl: 'https://api.github.production.com',
      clientToken: gitToken,
      tokenType: TokenType.ACCESS_TOKEN,
    ),
  );
  main_app.main();
}
