import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:skybase/core/helper/validator_helper.dart';
import 'package:skybase/config/themes/app_colors.dart';
import 'package:skybase/config/themes/app_style.dart';
import 'package:skybase/ui/views/login/login_notifier.dart';
import 'package:skybase/ui/widgets/base/notifier_view.dart';
import 'package:skybase/ui/widgets/colored_status_bar.dart';
import 'package:skybase/ui/widgets/keyboard_dismissible.dart';
import 'package:skybase/ui/widgets/sky_button.dart';
import 'package:skybase/ui/widgets/sky_form_field.dart';

class LoginView extends NotifierView<LoginNotifier> {
  static const String route = '/login';

  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissible(
      child: ColoredStatusBar.light(
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('txt_login'.tr(), style: AppStyle.headline2),
                            const SizedBox(height: 10),
                            Text(
                              'txt_login_subtitle'.tr(),
                              style: AppStyle.subtitle4,
                            ),
                          ],
                        ),
                      ),
                      const Flexible(
                        child: FlutterLogo(size: 160),
                      )
                    ],
                  ),
                  const SizedBox(height: 40),
                  Form(
                    key: notifier(context).formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        SkyFormField(
                          label: 'txt_phone'.tr(),
                          hint: 'txt_phone'.tr(),
                          controller: notifier(context).phoneController,
                          keyboardType: TextInputType.phone,
                          icon: Icons.phone,
                          validator: (value) => ValidatorHelper.field(
                            title: 'txt_phone'.tr(),
                            value: value.toString(),
                            regex: AppRegex.phone,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SkyPasswordFormField(
                          label: 'txt_password'.tr(),
                          hint: 'txt_password'.tr(),
                          controller: notifier(context).passwordController,
                          icon: Icons.lock,
                          hiddenText: notifier(context).isHiddenPassword,
                          endIcon: IconButton(
                            icon: const Icon(Icons.visibility_off),
                            onPressed: notifier(context).hidePassword,
                          ),
                          validator: (value) => ValidatorHelper.field(
                            title: 'txt_password'.tr(),
                            value: value.toString(),
                            regex: AppRegex.password,
                          ),
                        ),
                        const SizedBox(height: 20),
                        SkyButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            notifier(context).login(context);
                          },
                          text: 'txt_login'.tr(),
                          icon: Icons.arrow_forward,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 12),
                      SkyButton(
                        onPressed: () => notifier(context).bypassLogin(context),
                        text: 'txt_skip'.tr(),
                        icon: Icons.arrow_forward,
                        color: AppColors.primary,
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('txt_forgot_password'.tr()),
                          InkWell(
                            child: Text(
                              'txt_reset'.tr(),
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('txt_dont_have_account'.tr()),
                          InkWell(
                            child: Text(
                              'txt_register'.tr(),
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
