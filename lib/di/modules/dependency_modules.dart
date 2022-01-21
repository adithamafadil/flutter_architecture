import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DependencyModules {
  @lazySingleton
  Dio get dio => Dio();
}
