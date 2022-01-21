import 'package:flutter/widgets.dart';
import 'package:get/route_manager.dart';

class MyNavigation<T> {
  final String name;
  final Widget Function() page;
  final T? arguments;

  const MyNavigation({
    required this.name,
    required this.page,
    this.arguments,
  });

  GetPage getPage() => GetPage(name: name, page: page, arguments: arguments);
}
