import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class NotifierView<T> extends StatelessWidget {
  const NotifierView({Key? key}) : super(key: key);

  T notifier(BuildContext context, {bool listen = false}) =>
      Provider.of<T>(context, listen: listen);

  @override
  Widget build(BuildContext context);
}
