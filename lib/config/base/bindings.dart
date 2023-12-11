import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

abstract class Bindings {
  Widget Function(BuildContext context, GoRouterState state)? builder() {
    return (context, state) {
      Map<String, dynamic> args = {};
      if (state.extra != null) args = state.extra as Map<String, dynamic>;

      return MultiProvider(
        providers: dependencies(context, args),
        child: page(context, args),
      );
    };
  }

  List<SingleChildWidget> dependencies(
    BuildContext context,
    Map<String, dynamic> args,
  );

  Widget page(
    BuildContext context,
    Map<String, dynamic> args,
  );
}
