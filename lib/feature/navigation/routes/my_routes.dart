import 'package:get/get.dart';
import 'package:flutter_architecture/constants/constants.dart';
import 'package:flutter_architecture/feature/navigation/page/my_pages.dart';
import 'package:flutter_architecture/feature/screens/detail_screen/page/detail_page.dart';
import 'package:flutter_architecture/feature/screens/home_screen/page/home_page.dart';

class MyRoutes {
  static String get initialRoute => MyConstants.routes.initial;

  static List<MyNavigation> pages() => [
        MyNavigation(
          name: MyConstants.routes.initial,
          page: () => HomePage(),
        ),
        MyNavigation(
          name: MyConstants.routes.home,
          page: () => HomePage(),
        ),
        MyNavigation(
          name: MyConstants.routes.detail,
          page: () => DetailPage(),
          arguments: Get.arguments,
        ),
      ];
}
