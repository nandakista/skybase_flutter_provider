/* Created by
   Varcant
   nanda.kista@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class NotifierView<T> extends StatefulWidget {
  const NotifierView({super.key});

  Widget build(BuildContext context, T notifier);

  // ignore: non_constant_identifier_names
  Widget Consumable(Widget Function() builder) => Consumer<T>(
        builder: (context, notifier, child) {
          return builder();
        },
      );

  // ignore: non_constant_identifier_names
  Widget Selectable<V>({
    required V Function(T) selector,
    required Widget Function(V) builder,
  }) =>
      Selector<T, V>(
        selector: (context, notifier) => selector(notifier),
        builder: (context, value, child) {
          return builder(value);
        },
      );

  @override
  State<NotifierView<T>> createState() => _NotifierViewState<T>();
}

class _NotifierViewState<T> extends State<NotifierView<T>> {
  T notifier(BuildContext context, {bool listen = false}) =>
      Provider.of<T>(context, listen: listen);

  @override
  Widget build(BuildContext context) {
    return widget.build(context, notifier(context));
  }
}

class Observable<T> extends StatelessWidget {
  const Observable(this.builder, {super.key, this.listen = true});

  final Widget Function() builder;
  final bool listen;

  @override
  Widget build(BuildContext context) {
    return Consumer<T>(
      builder: (context, notifier, child) {
        return builder();
      },
    );
  }
}
