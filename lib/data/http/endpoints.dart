class Endpoints {
  Endpoints._();

  // base url
  // static const String baseUrl = "http://binevir.com/wp-json/binevir";
  static const String baseUrl = 'http://binevir.bokus.ru/';
  static const Duration receiveTimeout = Duration(milliseconds: 5000);
  static const Duration connectionTimeout = Duration(milliseconds: 5000);
  static const String products = '/api/products';
  static const String countries = '/api/countries';
  static const String applications = '/api/applications';
  static const String settings = '/api/settings';
  static const String guides = '/api/guides';
  static const String calculator = '/api/calculator/formula';
}
