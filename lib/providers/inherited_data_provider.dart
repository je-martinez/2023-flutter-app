import 'package:flutter/material.dart';

class InheritedDataProvider extends InheritedWidget {
  final ScrollController scrollController;
  const InheritedDataProvider(
      {required Widget child, required this.scrollController, Key? key})
      : super(child: child, key: key);
  @override
  bool updateShouldNotify(InheritedDataProvider oldWidget) =>
      scrollController != oldWidget.scrollController;
  static InheritedDataProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<InheritedDataProvider>()!;
}
