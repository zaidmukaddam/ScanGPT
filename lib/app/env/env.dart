import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  Env._();
  static String get fileName => 'env/.env';
  static String get baseUrl => dotenv.env['BASE_URL'] ?? 'NOT FOUND';
}
