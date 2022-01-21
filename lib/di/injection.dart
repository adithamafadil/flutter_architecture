import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_architecture/di/injection.config.dart';

final inject = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => $initGetIt(inject);
