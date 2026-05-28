import 'package:flutter_dotenv/flutter_dotenv.dart';

class VibePadding {
  static const double horizontalPadding = 15;
  static const double verticalPadding = 15;
}

class ServerConstant {
  static String serverURL = dotenv.env['BACKEND_URL']!;
}
