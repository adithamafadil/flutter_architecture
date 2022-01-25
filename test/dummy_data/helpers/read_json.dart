import 'dart:io';

String readJson(String fileLocation) {
  String dir = Directory.current.path;

  if (dir.endsWith('/test')) {
    dir = dir.replaceAll('/test', '');
  }

  return File('$dir/test/$fileLocation').readAsStringSync();
}
