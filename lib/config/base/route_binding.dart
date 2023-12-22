import 'package:provider/single_child_widget.dart';

abstract class Binding {
  List<SingleChildWidget> dependencies(dynamic args);
}
