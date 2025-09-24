import 'package:flutter/foundation.dart';

class APIService {
  static String baseUrl = kDebugMode ? 'http://192.168.100.19:3000/api' : (kProfileMode ? 'prod' : 'prod');
}
