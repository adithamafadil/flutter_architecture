import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:flutter_architecture/di/injection.dart';
import 'package:flutter_architecture/feature/navigation/routes/my_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: MyRoutes.initialRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      getPages: MyRoutes.pages().map((page) => page.getPage()).toList(),
    );
  }
}
