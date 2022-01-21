import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:flutter_architecture/di/injection.dart';
import 'package:flutter_architecture/feature/navigation/routes/my_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: MyRoutes.initialRoute,
      getPages: MyRoutes.pages().map((page) => page.getPage()).toList(),
    );
  }
}
