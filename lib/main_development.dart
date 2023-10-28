import './main.dart' as main_app;
import 'config/environment/app_env.dart';
import 'config/environment/config_data.dart';
import 'config/network/api_token_manager.dart';

void main() async {
  AppEnv.set(
    environment: Environment.DEVELOPMENT,
    configuration: ConfigData(
      baseUrl: 'https://api.github.com',
      clientToken: 'Some Client Token',
      tokenType: TokenType.ACCESS_TOKEN,
    ),
  );
  main_app.main();
}