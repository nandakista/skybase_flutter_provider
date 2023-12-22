import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'route_binding.dart';

class RoutePage extends GoRoute {
  final Binding? binding;
  final Widget Function(dynamic) page;

  RoutePage({
    required super.name,
    required this.page,
    this.binding,
    super.onExit,
    super.pageBuilder,
    super.parentNavigatorKey,
    super.redirect,
    super.routes,
  }) : super(
          path: name!,
          builder: (context, state) {
            dynamic args;
            if (state.extra != null) args = state.extra;
            if ((binding?.dependencies(args) ?? []).isEmpty) return page(args);

            return MultiProvider(
              providers: binding!.dependencies(args),
              child: page(args),
            );
          },
        );
}
