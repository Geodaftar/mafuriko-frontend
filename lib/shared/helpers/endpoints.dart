class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "http://localhost:3000/v1.0";
  static const String apiBaseUrl = "https://mafu-back.vercel.app";
  static const String placesUrl = 'https://places.googleapis.com/v1/places';

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 15000;
}
