class MyConstants {
  static _Endpoint endpoint = const _Endpoint();
  static _MyRoutes routes = const _MyRoutes();
}

class _MyApiUrl {
  const _MyApiUrl();

  String get baseUrl => 'http://makeup-api.herokuapp.com/api/v1';
}

class _Endpoint {
  const _Endpoint();
  final _MyApiUrl _myApiUrl = const _MyApiUrl();

  String get product => '${_myApiUrl.baseUrl}/products.json?brand=nyx';
}

class _MyRoutes {
  const _MyRoutes();

  String get initial => '/';
  String get home => '/home';
  String get detail => '/detail';
}
