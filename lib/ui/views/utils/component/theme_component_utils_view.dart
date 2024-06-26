import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skybase/config/themes/theme_manager.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';

class ThemeComponentUtilsView extends StatefulWidget {
  static const String route = 'theme-component';

  const ThemeComponentUtilsView({super.key});

  @override
  State<ThemeComponentUtilsView> createState() =>
      _ThemeComponentUtilsViewState();
}

class _ThemeComponentUtilsViewState extends State<ThemeComponentUtilsView> {
  bool switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SkyAppBar.secondary(title: 'Theme Component'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Is Dark Mode'),
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
            Radio(
              value: switchValue,
              groupValue: true,
              onChanged: (value) => setState(() {
                switchValue = !switchValue;
              }),
            ),
            Switch(
              value: switchValue,
              onChanged: (value) => setState(() {
                switchValue = !switchValue;
              }),
            ),
            Checkbox(
              value: switchValue,
              onChanged: (value) => setState(() {
                switchValue = !switchValue;
              }),
            ),
          ],
        ),
      ),
    );
  }
}
