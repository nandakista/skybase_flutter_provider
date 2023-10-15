import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:skybase/config/auth_manager/auth_manager.dart';
import 'package:skybase/config/base/main_navigation.dart';
import 'package:skybase/core/helper/dialog_helper.dart';
import 'package:skybase/core/helper/validator_helper.dart';
import 'package:skybase/data/repositories/auth/auth_repository.dart';
import 'package:skybase/ui/views/main_navigation/main_nav_view.dart';

class LoginNotifier extends ChangeNotifier {
  final AuthRepository repository;
  CancelToken cancelToken = CancelToken();

  LoginNotifier(this.repository);

  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  bool isHiddenPassword = true;

  void hidePassword() {
    isHiddenPassword = !isHiddenPassword;
    notifyListeners();
  }

  void login(BuildContext context) async {
    if (ValidatorHelper.validateForm(formKey)) {
      try {
        LoadingDialog.show(context);
        await repository.login(
          phoneNumber: phoneController.text,
          email: emailController.text,
          password: passwordController.text,
        );
        if (context.mounted) {
          LoadingDialog.dismiss(context);
          MainNavigation.popAllReplacement(context, MainNavView.route);
        }
      } catch (e) {
        LoadingDialog.dismiss(context);
        DialogHelper.failed(context: context, message: e.toString());
      }
    }
  }

  void bypassLogin(BuildContext context) async {
    LoadingDialog.show(context);
    try {
      final response = await repository.getProfile(
        cancelToken: cancelToken,
        username: 'nandakista',
      );
      await AuthManager.find.saveAuthData(
        user: response,
        token: 'dummy',
        refreshToken: 'dummyRefresh',
      );
      if (context.mounted) {
        LoadingDialog.dismiss(context);
        MainNavigation.popAllReplacement(context, MainNavView.route);
      }
    } catch (e) {
      LoadingDialog.dismiss(context);
      DialogHelper.failed(context: context, message: e.toString());
    }
  }

  @override
  void dispose() {
    cancelToken.cancel();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
